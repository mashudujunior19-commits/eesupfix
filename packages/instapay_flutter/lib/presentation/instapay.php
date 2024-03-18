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

<div class="button-container">
<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Get raw POST data
    $rawData = file_get_contents("php://input");

    // Decode JSON data into associative array
    $data = json_decode($rawData, true);

    // Extract parameters from the parsed data
    $mUUID = $data['m_uuid'] ?? null;
    $mAccountUUID = $data['m_account_uuid'] ?? null;
    $bEmail = $data['b_email'] ?? null;
    $bMobile = $data['b_mobile'] ?? null;
    $mReturnUrl = $data['m_return_url'] ?? null;
    $mNotifyUrl = $data['m_notify_url'] ?? null;
    $mTxId = $data['m_tx_id'] ?? null;
    $mTxAmount = $data['m_tx_amount'] ?? null;
    $mTxCurrency = $data['m_tx_currency'] ?? null;
    $mTxItemName = $data['m_tx_item_name'] ?? null;
    $mTxItemDescription = $data['m_tx_item_description'] ?? null;
    $mTxOrderNr = $data['m_tx_order_nr'] ?? null;
    $mCategory1 = $data['m_category_1'] ?? null;
    $mCategory2 = $data['m_category_2'] ?? null;
    $mCategory3 = $data['m_category_3'] ?? null;
    $mCardAllowed = $data['m_card_allowed'] ?? null;
    $mIeftAllowed = $data['m_ieft_allowed'] ?? null;
    $mChipsAllowed = $data['m_chips_allowed'] ?? null;
    $mTridentAllowed = $data['m_trident_allowed'] ?? null;
    $mMpassAllowed = $data['m_mpass_allowed'] ?? null;
    $mPayatAllowed = $data['m_payat_allowed'] ?? null;
    $mZapperAllowed = $data['m_zapper_allowed'] ?? null;
    $mSnapscanAllowed = $data['m_snapscan_allowed'] ?? null;
    $mTxDueDate = $data['m_tx_due_date'] ?? null;
    $bName = $data['b_name'] ?? null;
    $bSurname = $data['b_surname'] ?? null;
    $mMessage = $data['m_message'] ?? null;
    $mSiteName = $data['m_site_name'] ?? null;
    $mBack2shopUrl = $data['m_back2shop_url'] ?? null;


    $checksum_string = array(
        $mUUID,
        $mAccountUUID,
        $mTxId,
        preg_replace('/\D/', '', $mTxAmount),
        $mTxCurrency,
        $data['secret']
    );
  $checksum = md5(implode('_', $checksum_string));
?>
    <form action="https://webpay-sandbox.omnea.co.za" method="POST">
        <input type="hidden" name="m_uuid" value="<?= $mUUID?>">
        <input type="hidden" name="m_account_uuid" value="<?= $mAccountUUID?>">
        <input type="hidden" name="b_email" value="<?= $bEmail?>">
        <input type="hidden" name="b_mobile" value="<?= $bMobile?>">
        <input type="hidden" name="m_return_url" value="<?= $mReturnUrl?>">
        <input type="hidden" name="m_notify_url" value="<?= $mNotifyUrl?>">
        <input type="hidden" name="m_tx_id" value="<?= $mTxId?>">
        <input type="hidden" name="m_tx_amount" value="<?= $mTxAmount?>">
        <input type="hidden" name="m_tx_currency" value="<?= $mTxCurrency?>">
        <input type="hidden" name="m_tx_item_name" value="<?= $mTxItemName?>">
        <input type="hidden" name="m_tx_item_description" value="<?= $mTxItemDescription?>">
        <input type="hidden" name="m_tx_order_nr" value="<?= $mTxOrderNr?>">
        <input type="hidden" name="m_category_1" value="<?= $mCategory1?>">
        <input type="hidden" name="m_category_2" value="<?= $mCategory2?>">
        <input type="hidden" name="m_category_3" value="<?= $mCategory3?>">
        <input type="hidden" name="m_card_allowed" value="<?= $mCardAllowed?>">
        <input type="hidden" name="m_ieft_allowed" value="<?= $mIeftAllowed?>">
        <input type="hidden" name="m_chips_allowed" value="<?= $mChipsAllowed?>">
        <input type="hidden" name="m_trident_allowed" value="<?= $mTridentAllowed?>">
        <input type="hidden" name="m_mpass_allowed" value="<?= $mMpassAllowed?>">
        <input type="hidden" name="m_payat_allowed" value="<?= $mPayatAllowed?>">
        <input type="hidden" name="m_zapper_allowed" value="<?= $mZapperAllowed?>">
        <input type="hidden" name="m_snapscan_allowed" value="<?= $mSnapscanAllowed?>">
        <input type="hidden" name="checksum" value="<?= $checksum?>">
        <input type="hidden" name="m_tx_due_date" value="<?= $mTxDueDate?>">
        <input type="hidden" name="b_name" value="<?= $bName?>">
        <input type="hidden" name="b_surname" value="<?= $bSurname?>">
        <input type="hidden" name="m_message" value="<?= $mMessage?>">
        <input type="hidden" name="m_site_name" value="<?= $mSiteName?>">
        <input type="hidden" name="m_back2shop_url" value="<?= $mBack2shopUrl?>">
        
        
        <input type="submit" class="btn" value="Start Payment">
    </form>
<?php } ?>
</div>
</body>
</html>