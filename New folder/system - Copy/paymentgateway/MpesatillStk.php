<?php


function MpesatillStk_validate_config()
{
    global $config;
    if (empty($config['mpesa_till_shortcode_code']) || empty($config['mpesa_till_consumer_key']) || empty($config['mpesa_till_consumer_secret']) || empty($config['mpesa_till_partyb'])) {
        sendTelegram("Bank Stk payment gateway not configured");
        r2(U . 'order/balance', 'w', Lang::T("Admin has not yet setup the payment gateway, please tell admin"));
    }
}

function MpesatillStk_show_config()
{
    global $ui, $config;
    $ui->assign('env', json_decode(file_get_contents('system/paymentgateway/mpesa_env.json'), true));
    $ui->assign('_title', 'M-Pesa - Payment Gateway (for till number only) - ' . $config['CompanyName']);
    $ui->display('mpesatill.tpl');
}


function MpesatillStk_save_config()
{
    global $admin, $_L;
    $mpesa_consumer_key = _post('mpesa_consumer_key');
    $mpesa_consumer_secret = _post('mpesa_consumer_secret');
    $mpesa_business_code = _post('mpesa_business_code');
    $mpesa_till = _post('mpesa_till');
    $mpesa_pass_key = _post('mpesa_pass_key');
    $mpesa_env = _post('mpesa_env');
    $d = ORM::for_table('tbl_appconfig')->where('setting', 'mpesa_till_consumer_key')->find_one();
    if ($d) {
        $d->value = $mpesa_consumer_key;
        $d->save();
    } else {
        $d = ORM::for_table('tbl_appconfig')->create();
        $d->setting = 'mpesa_till_consumer_key';
        $d->value = $mpesa_consumer_key;
        $d->save();
    }
    $d = ORM::for_table('tbl_appconfig')->where('setting', 'mpesa_till_consumer_secret')->find_one();
    if ($d) {
        $d->value = $mpesa_consumer_secret;
        $d->save();
    } else {
        $d = ORM::for_table('tbl_appconfig')->create();
        $d->setting = 'mpesa_till_consumer_secret';
        $d->value = $mpesa_consumer_secret;
        $d->save();
    }

    $d = ORM::for_table('tbl_appconfig')->where('setting', 'mpesa_till_shortcode_code')->find_one();
    if ($d) {
        $d->value = $mpesa_business_code;
        $d->save();
    } else {
        $d = ORM::for_table('tbl_appconfig')->create();
        $d->setting = 'mpesa_till_shortcode_code';
        $d->value = $mpesa_business_code;
        $d->save();
    }

    $d = ORM::for_table('tbl_appconfig')->where('setting', 'mpesa_till_partyb')->find_one();
    if ($d) {
        $d->value = $mpesa_till;
        $d->save();
    } else {
        $d = ORM::for_table('tbl_appconfig')->create();
        $d->setting = 'mpesa_till_partyb';
        $d->value = $mpesa_till;
        $d->save();
    }

    $d = ORM::for_table('tbl_appconfig')->where('setting', 'mpesa_till_pass_key')->find_one();
    if ($d) {
        $d->value = $mpesa_pass_key;
        $d->save();
    } else {
        $d = ORM::for_table('tbl_appconfig')->create();
        $d->setting = 'mpesa_till_pass_key';
        $d->value = $mpesa_pass_key;
        $d->save();
    }
    $d = ORM::for_table('tbl_appconfig')->where('setting', 'mpesa_env')->find_one();
    if ($d) {
        $d->value = $mpesa_env;
        $d->save();
    } else {
        $d = ORM::for_table('tbl_appconfig')->create();
        $d->setting = 'mpesa_env';
        $d->value = $mpesa_env;
        $d->save();
    }

    _log('[' . $admin['username'] . ']: M-Pesa ' . $_L['Settings_Saved_Successfully'] . json_encode($_POST['mpesa_channel']), 'Admin', $admin['id']);

    r2(U . 'paymentgateway/MpesatillStk', 's', $_L['Settings_Saved_Successfully']);
}


function MpesatillStk_create_transaction($trx, $user)
{


    $url = (U . "plugin/initiatetillstk");

    $d = ORM::for_table('tbl_payment_gateway')
        ->where('username', $user['username'])
        ->where('status', 1)
        ->find_one();
    $d->gateway_trx_id = '';
    $d->payment_method = 'Mpesa till STK';
    $d->pg_url_payment = $url;
    $d->pg_request = '';
    $d->expired_date = date('Y-m-d H:i:s', strtotime("+5 minutes"));
    $d->save();

    r2(U . "order/view/" . $d['id'], 's', Lang::T("Create Transaction Success, Please click pay now to process payment"));

    die();
}




function MpesatillStk_payment_notification()
{
    $captureLogs = file_get_contents("php://input");

    $analizzare = json_decode($captureLogs);
    ///  sleep(10);
    file_put_contents('back.log', $captureLogs, FILE_APPEND);
    $response_code   = $analizzare->Body->stkCallback->ResultCode;
    $resultDesc      = ($analizzare->Body->stkCallback->ResultDesc);
    $merchant_req_id = ($analizzare->Body->stkCallback->MerchantRequestID);
    $checkout_req_id = ($analizzare->Body->stkCallback->CheckoutRequestID);


    $amount_paid     = ($analizzare->Body->stkCallback->CallbackMetadata->Item['0']->Value); //get the amount value
    $mpesa_code      = ($analizzare->Body->stkCallback->CallbackMetadata->Item['1']->Value); //mpesa transaction code..
    $sender_phone    = ($analizzare->Body->stkCallback->CallbackMetadata->Item['4']->Value); //Telephone Number






    $PaymentGatewayRecord = ORM::for_table('tbl_payment_gateway')
        ->where('checkout', $checkout_req_id)
        ->where('status', 1) // Add this line to filter by status
        ->order_by_desc('id')
        ->find_one();

    $uname = $PaymentGatewayRecord->username;


    $plan_id = $PaymentGatewayRecord->plan_id;


    $mac_address = $PaymentGatewayRecord->mac_address;

    $user = $PaymentGatewayRecord;


    $userid = ORM::for_table('tbl_customers')
        ->where('username', $uname)
        ->order_by_desc('id')
        ->find_one();

    $userid->username = $uname;
    $userid->save();




    $plans = ORM::for_table('tbl_plans')
        ->where('id', $plan_id)

        ->order_by_desc('id')
        ->find_one();











    if ($response_code == "1032") {
        $now = date('Y-m-d H:i:s');
        $PaymentGatewayRecord->paid_date = $now;
        $PaymentGatewayRecord->status = 4;
        $PaymentGatewayRecord->save();

        exit();
    }




    if ($response_code == "1037") {


        $PaymentGatewayRecord->status = 1;
        $PaymentGatewayRecord->pg_paid_response = 'User failed to enter pin';
        $PaymentGatewayRecord->save();

        exit();
    }

    if ($response_code == "1") {


        $PaymentGatewayRecord->status = 1;
        $PaymentGatewayRecord->pg_paid_response = 'Not enough balance';
        $PaymentGatewayRecord->save();

        exit();
    }


    if ($response_code == "2001") {


        $PaymentGatewayRecord->status = 1;
        $PaymentGatewayRecord->pg_paid_response = 'Wrong Mpesa pin';
        $PaymentGatewayRecord->save();

        exit();
    }

    if ($response_code == "0") {


        $now = date('Y-m-d H:i:s');

        $date = date('Y-m-d');
        $time = date('H:i:s');






        $check_mpesa = ORM::for_table('tbl_payment_gateway')
            ->where('gateway_trx_id', $mpesa_code)
            ->find_one();


        if ($check_mpesa) {

            echo "double callback, ignore one";

            die;
        }




        $plan_type = $plans->type;

        $UserId = $userid->id;




        if (!Package::rechargeUser($UserId, $user['routers'], $user['plan_id'], $user['gateway'], $mpesa_code)) {






            $PaymentGatewayRecord->status = 2;
            $PaymentGatewayRecord->paid_date = $now;
            $PaymentGatewayRecord->gateway_trx_id = $mpesa_code;
            $PaymentGatewayRecord->save();





            $username = $PaymentGatewayRecord->username;

            // Save transaction data to tbl_transactions
            $transaction = ORM::for_table('tbl_transactions')->create();
            $transaction->invoice = $mpesa_code;
            $transaction->username = $PaymentGatewayRecord->username;
            $transaction->plan_name = $PaymentGatewayRecord->plan_name;
            $transaction->price = $amount_paid;
            $transaction->recharged_on = $date;
            $transaction->recharged_time = $time;
            $transaction->expiration = $now;
            $transaction->time = $now;
            $transaction->method = $PaymentGatewayRecord->payment_method;
            $transaction->routers = 0;
            $transaction->Type = 'Balance';
            $transaction->save();
        } else {


            //lets update tbl_recharges
            /*
               $transaction = ORM::for_table('tbl_transactions')->create();
               $transaction->invoice = $mpesa_code;
               $transaction->username = $PaymentGatewayRecord->username;
               $transaction->plan_name = $PaymentGatewayRecord->plan_name;
               $transaction->price = $amount_paid;
               $transaction->recharged_on = $date;
               $transaction->recharged_time = $time;
               $transaction->expiration = $now;
               $transaction->time = $now;
                $transaction->method = $PaymentGatewayRecord->payment_method;
                $transaction->routers = 0;
               $transaction->Type = $PaymentGatewayRecord->routers;
               $transaction->save();

*/




            $PaymentGatewayRecord->status = 2;
            $PaymentGatewayRecord->paid_date = $now;
            $PaymentGatewayRecord->gateway_trx_id = $mpesa_code;
            $PaymentGatewayRecord->save();
        }











        /*
              
              
                  $checkid = ORM::for_table('tbl_customers')
        ->where('username', $username)
        ->find_one();
              
              
              
              
              
              $customerid=$checkid->id;
              
              
              
              
              
              
              
              
             $recharge = ORM::for_table('tbl_user_recharges')->create();
             $recharge->customer_id = $customerid;
             $recharge->username = $PaymentGatewayRecord->username;
             $recharge->plan_id = $PaymentGatewayRecord->plan_id;
             $recharge->price = $amount_paid;
             $recharge->recharged_on = $date;
             $recharge->recharged_time = $time;
             $recharge->expiration = $now;
              $recharge->time = $now;
              $recharge->method = $PaymentGatewayRecord->payment_method;
             $recharge->routers = 0;
             $recharge->Type = 'Balance';
            $recharge->save();
              
              
              
              */




        //   $user = ORM::for_table('tbl_customers')
        //   ->where('username', $username)
        //   ->find_one();

        //   $currentBalance = $user->balance;

        //     $user->balance = $currentBalance + $amount_paid;
        //     $user->save();

        //   exit();



    }
}
