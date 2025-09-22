<!DOCTYPE html>
<html>
<head>
    <title>Payment Confirmation</title>
</head>
<body>
    <h1>Payment Confirmation</h1>
    <p>Dear Customer,</p>
    <p>Your payment has been successfully processed.</p>
    <p><strong>Transaction ID:</strong> {{ $transaction->id }}</p>
    <p><strong>Amount:</strong> {{ $transaction->amount }}</p>
    <p>Thank you for your payment.</p>
</body>
</html>
