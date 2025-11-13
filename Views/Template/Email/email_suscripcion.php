<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nueva suscripción</title>
</head>
<body style="margin:0;padding:0;background-color:#f6f6f6;">
    <table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0" style="background-color:#f6f6f6;">
        <tr>
            <td align="center" style="padding:20px 10px;">
                <table role="presentation" width="600" cellspacing="0" cellpadding="0" border="0" style="width:100%;max-width:600px;background:#ffffff;border:1px solid #e5e5e5;">
                    <tr>
                        <td align="center" style="padding:20px 20px 10px 20px;font-family:Arial,Helvetica,sans-serif;color:#0a4661;font-size:22px;line-height:28px;"><?= NOMBRE_EMPESA ?></td>
                    </tr>
                    <tr>
                        <td style="padding:0 20px 10px 20px;font-family:Arial,Helvetica,sans-serif;color:#555555;font-size:15px;line-height:22px;text-align:center;">Nuevo suscriptor registrado.</td>
                    </tr>
                    <tr>
                        <td style="padding:0 20px 6px 20px;font-family:Arial,Helvetica,sans-serif;color:#333333;font-size:14px;line-height:22px;text-align:center;">Nombre: <strong><?= $data['nombreSuscriptor']; ?></strong></td>
                    </tr>
                    <tr>
                        <td style="padding:0 20px 20px 20px;font-family:Arial,Helvetica,sans-serif;color:#333333;font-size:14px;line-height:22px;text-align:center;">Email: <strong><?= $data['emailSuscriptor']; ?></strong></td>
                    </tr>
                    <tr>
                        <td align="center" style="padding:0 20px 20px 20px;font-family:Arial,Helvetica,sans-serif;color:#0a4661;font-size:14px;line-height:20px;">
                            <a href="<?= BASE_URL; ?>" target="_blank" style="color:#0a4661;text-decoration:none;">Ir a la tienda</a>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
</html>
