<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bienvenido</title>
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
                        <td style="padding:0 20px 10px 20px;font-family:Arial,Helvetica,sans-serif;color:#244180;font-size:18px;line-height:26px;text-align:center;">Hola <?= $data['nombreUsuario']; ?></td>
                    </tr>
                    <tr>
                        <td style="padding:0 20px 10px 20px;font-family:Arial,Helvetica,sans-serif;color:#555555;font-size:15px;line-height:22px;text-align:center;">Bienvenido a nuestra tienda en línea. Accede con tus credenciales:</td>
                    </tr>
                    <tr>
                        <td style="padding:0 20px;font-family:Arial,Helvetica,sans-serif;color:#333333;font-size:14px;line-height:22px;text-align:center;">Usuario: <strong><?= $data['email']; ?></strong></td>
                    </tr>
                    <tr>
                        <td style="padding:0 20px 20px 20px;font-family:Arial,Helvetica,sans-serif;color:#333333;font-size:14px;line-height:22px;text-align:center;">Contraseña: <strong><?= $data['password']; ?></strong></td>
                    </tr>
                    <tr>
                        <td align="center" style="padding:10px 20px 20px 20px;">
                            <a href="<?= BASE_URL; ?>" target="_blank" style="display:inline-block;background-color:#307cf4;color:#ffffff;text-decoration:none;font-family:Arial,Helvetica,sans-serif;font-size:16px;line-height:20px;padding:12px 24px;border-radius:4px;">Comprar ahora</a>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" style="padding:0 20px 20px 20px;font-family:Arial,Helvetica,sans-serif;color:#0a4661;font-size:14px;line-height:20px;">
                            <a href="<?= BASE_URL; ?>" target="_blank" style="color:#0a4661;text-decoration:none;"><?= NOMBRE_EMPESA ?></a>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
</html>
