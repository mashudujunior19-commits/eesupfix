<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <title> </title>
</head>
<style type="text/css">
body {
  font-family: Arial, Helvetica, sans-serif;
  font-size: 16px;
  color: #333;
  background-color: #fff;
  margin: 20px; 
}

.id {
  color: #28a745; /* Success green */
  margin-bottom: 10px; 
}


.button-container {
  display: flex;
  flex-direction: column;  /* Arrange items in a column */
  align-items: center;      /* Center items horizontally */
  margin-top: 20px; 
    align-items: center;
  justify-content: center;       /* Add a bit of spacing */
}

.btn {
    width: 200px;
  height: 50px;
  font-size: 16px;

  background-color: black;
  color: white;
  padding: 10px 20px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  transition: background-color 0.3s; 
  margin-bottom: 10px;  /* Add spacing between buttons */
}

.btn:hover {
  background-color: #0056b3; 
}

</style>
<body>
<div class="price-display" id="price-display">
  Click the button below to start the payment process.
</div>

<div class ="button-container">
    <form action="https://webpay-sandbox.omnea.co.za" method="POST">
        <input type="hidden" name="m_uuid" value="e8aff31a-1aaf-4271-8ade-88395d214071">
        <input type="hidden" name="m_account_uuid" value="9370832a-ce36-43d6-83f3-e14d611bc2de">
        <input type="hidden" name="b_email" value="misomenze6@gmail.com">
        <input type="hidden" name="b_mobile" value="+27719582572">
        <input type="hidden" name="m_return_url" value="https: //eesup.com/wp-content/payment_success.php">
        <input type="hidden" name="m_notify_url" value="https://eesup-dart-frog-dev-api-hz7p5cleia-uc.a.run.app/v1/payments/insta_pay">
        <input type="hidden" name="m_tx_id" value="162a4b33-9b27-4a0d-bbad-d6f0bf4fc6e0">
        <input type="hidden" name="m_tx_amount" value="952.72">
        <input type="hidden" name="m_tx_currency" value="ZAR">
        <input type="hidden" name="m_tx_item_name" value="Order: 101965">
        <input type="hidden" name="m_tx_item_description" value="Order 101965">
        <input type="hidden" name="m_tx_order_nr" value="EESNR6pLMUjp7780j5zY">
        <input type="hidden" name="m_category_1" value="101965">
        <input type="hidden" name="m_category_2" value="Order">
        <input type="hidden" name="m_category_3" value="eesup_iyxjp1tlR2rClGJZUK6B0ZqBs8CR9hjqrJM3PrABKQEq">
        <input type="hidden" name="m_card_allowed" value="1">
        <input type="hidden" name="m_ieft_allowed" value="1">
        <input type="hidden" name="m_chips_allowed" value="0">
        <input type="hidden" name="m_trident_allowed" value="0">
        <input type="hidden" name="m_mpass_allowed" value="0">
        <input type="hidden" name="m_payat_allowed" value="0">
        <input type="hidden" name="m_zapper_allowed" value="0">
        <input type="hidden" name="m_snapscan_allowed" value="0">
        <input type="hidden" name="checksum" value="fb16d0f599f8aec970b3eb8a1369d458">
        <input type="hidden" name="m_tx_due_date" value="33SuP@2024">
        <input type="hidden" name="b_name" value="John">
        <input type="hidden" name="b_surname" value="Doe">
        <input type="hidden" name="m_message" value="Payment for order 101965">
        <input type="hidden" name="m_site_name" value="EESUp">
        <input type="hidden" name="m_back2shop_url" value="https://eesup.com/wp-content/payment_failed.php">        
        
        <input type="submit" class="btn" id="submit-button" value="Start Payment">
    </form>
</div>
</body>
</html>