<?php

$flow = json_decode(file_get_contents('php://input'), true);
$_POST = $flow;
if ($_POST) {
	require '../lib/PHPMailer/PHPMailerAutoload.php';
	// Заголовок письма меняем на тот, который нужен нам
	//	$thm = "Обратная связь с " . $_SERVER['SEVER_NAME'];
	$thm = "Обратная связь с " . $_SERVER['HTTP_HOST'];
	$fields = '';
	$comment = '';
	//Эти блоки данных нужно копи-пастить. Кроме переменной, не забываем менять Название внутри <span>
	if (!empty($_POST['task']) and $_POST['task'] == "calculator") {
		if (!empty($_POST['name'])) {
			$fields .= '<tr>
                    <td style="text-align: right;width: 30%; padding-top: 5px;padding-bottom: 5px;">
                        <span style="font-size: 14px; color: #999999;padding-right: 20px; display:block;"> Имя</span>
                    </td>
                    <td style="text-align:left;width: 70% ; padding-top: 5px;padding-bottom: 5px; vertical-align: top;">
                        <span style="font-size: 18px; color: #000000">' . $_POST['name'] . '</span>
                    </td>
                </tr>';
		}
		if (!empty($_POST['phone'])) {
			$fields .= '<tr>
                    <td style="text-align: right;width: 30%; padding-top: 5px;padding-bottom: 5px;">
                        <span style="font-size: 14px; color: #999999;padding-right: 20px; display:block;"> Телефон</span>
                    </td>
                    <td style="text-align:left;width: 70% ; padding-top: 5px;padding-bottom: 5px; vertical-align: top;">
                        <span style="font-size: 18px; color: #000000">' . $_POST['phone'] . '</span>
                    </td>
                </tr>';
		}
		if (!empty($_POST['email'])) {
			$fields .= '<tr>
                    <td style="text-align: right;width: 30%; padding-top: 5px;padding-bottom: 5px;">
                        <span style="font-size: 14px; color: #999999;padding-right: 20px; display:block;"> Email</span>
                    </td>
                    <td style="text-align:left;width: 70% ; padding-top: 5px;padding-bottom: 5px; vertical-align: top;">
                        <span style="font-size: 18px; color: #000000">' . $_POST['email'] . '</span>
                    </td>
                </tr>';
		}
		if (!empty($_POST['site'])) {
			$fields .= '<tr>
                    <td style="text-align: right;width: 30%; padding-top: 5px;padding-bottom: 5px;">
                        <span style="font-size: 14px; color: #999999;padding-right: 20px; display:block;"> Сайт</span>
                    </td>
                    <td style="text-align:left;width: 70% ; padding-top: 5px;padding-bottom: 5px; vertical-align: top;">
                        <span style="font-size: 18px; color: #000000">' . $_POST['site'] . '</span>
                    </td>
                </tr>';
		}
		if (!empty($_POST['service'])) {
			$fields .= '<tr>
                    <td style="text-align: right;width: 30%; padding-top: 5px;padding-bottom: 5px;">
                        <span style="font-size: 14px; color: #999999;padding-right: 20px; display:block;"> Услуга</span>
                    </td>
                    <td style="text-align:left;width: 70% ; padding-top: 5px;padding-bottom: 5px; vertical-align: top;">
                        <span style="font-size: 18px; color: #000000">' . $_POST['service'] . '</span>
                    </td>
                </tr>';
		}
		if (!empty($_POST['comment'])) {
			$fields .= '<tr>
                        <td style="text-align: right;width: 30%; padding-top: 5px;padding-bottom: 5px;">
                            <span style="font-size: 14px; color: #999999;padding-right: 20px; display:block;"> Комментарий</span>
                        </td>
                        <td style="text-align:left;width: 70% ; padding-top: 5px;padding-bottom: 5px; vertical-align: top;">
                            <span style="font-size: 18px; color: #000000">' . $_POST['comment'] . '</span>
                        </td>
                    </tr>';
		}
	}

	//Само письмо (отправляется администратору)
	//Вместо самого первого $_SERVER['SERVER_NAME'] должен стоять логотип компании, src обязательно абсолютный путь.
	//Например: <img alt="' . $_SERVER['SERVER_NAME'] . '" src="http://mysite.ru/images/logo.png" />
	//Естественно убедиться, что логотип доступен для просмотра по указанному адресу
	$msg = '<table style="width: 600px; margin:0 auto;background-image: url(http://tutmee.ru/images/main-bg.jpg);background-repeat:repeat-y ;background-position: top center; border-spacing: 0; " cellspacing="0" cellpadding="0">
            <tr>
                <td style="font-family:tahoma;">
                    <table style="width: 600px; margin: 0 auto" cellspacing="0" cellpadding="0">
                        <tr>
                            <td>
                                <table style=" margin: 0 auto;width: 179px;" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td style="text-align: center; padding-top: 30px">
                                            <img alt="' . $_SERVER['SERVER_NAME'] . '" src="http://' . $_SERVER['SERVER_NAME'] . '/images/logo2.png" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
           <!-- <tr>
                <td>
                    <table style="margin: 0 auto; width: 350px; border-bottom: 1px solid #C7C7C7;font-family: Tahoma" cellspacing="0" cellpadding="0">
                        <tr>
                            <td style="text-align: center; font-size: 30px;font-weight: 100; text-transform: uppercase;padding-top: 40px;">
                                <span>Заявка</span>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: center; font-size: 18px;font-weight: 100;padding-bottom: 12px">
                                <span>от</span>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>-->
            <tr>
                <td>
                    <table style="font-family: Tahoma;border-top: 1px solid #ffffff;margin: 0 auto;width: 350px;" cellspacing="0" cellpadding="0">
                        ' . $fields . '
                    </table>
                </td>
            </tr>
            ' . $comment . '
        </table>
        <table style="width: 600px; margin: 0 auto;background-image: url(http://tutmee.ru/images/t2-bg.jpg);background-repeat:  no-repeat; height: 457px;background-position: bottom center;" cellspacing="0" cellpadding="0" >
            <tr>
                <td style="vertical-align: bottom;">
                    <table style="width: 486px; border-bottom:1px solid #C7C7C7;margin: 0 auto; height: 1px" cellspacing="0" cellpadding="0" ></table>
                </td>
            </tr>
            <tr>
                <td style="vertical-align: top">
                    <table style="width: 486px; border-top:1px solid #ffffff;margin: 0 auto;" cellspacing="0" cellpadding="0">
                        <tr>
                            <td style="vertical-align: top;text-align: center; padding-top: 12px;">
//                                <a href="http://tutmee.ru/" style="text-align: left; font-size: 12px; font-family: Arial;color: #AAAAAA;text-decoration: none;display: inline-block;">
//                                    <img src="http://tutmee.ru/images/dev-logo.png" alt="TutMee Создание дизайна и разработка сайтов LTD Tutmee.ru"><br/>
//                                </a>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        ';

	//Данный код отправки работает корректно на серверах в интернете (с SMTP авторизацией)
	//*Если домен сайта после сдачи проекта будет размещен на нашем сервере, нужно сказать Мише, чтобы он создал почту noreply@АДРЕС_САЙТА.ru
	//*и выдал логин и пароль, который нужно прописать в $mail->Host
	$mail = new PHPMailer();
	$mail->isSMTP();
	$mail->IsHTML(true);
	$mail->CharSet = "utf-8";
	$mail->Host = "smtp.tutmee.ru";
	$mail->Port = 25;
	$mail->SMTPAuth = true;
	$mail->Username = "noreply@tutmee.ru";
	$mail->Password = "CsKHUvx9sya7mztZMzlO";
	$mail->setFrom($mail->Username);
	/* Массив адресов доставки почты */
	$emails = array(
		"asdalexey@yandex.ru",
	);
	foreach ($emails as $email) {
		$mail->addAddress($email); // кому - адрес, Имя
	}
	$mail->Subject = $thm;
	$mail->Body = $msg;
	if (!$mail->Send())
		die('Mailer Error: ' . $mail->ErrorInfo);

	//Далее проверяем не пустой ли email, и если не пустой, то формируем письмо "спасибо" для пользователя.
	if (!empty($_POST['email'])) {

		//Здесь как в примере выше - нужно заменить $_SERVER['SERVER_NAME'] на логотип.
		//Только тут заменяем не первый попавшийся SERVER_NAME, а последний.
		$msg = '<table style="width: 600px; margin:0 auto;background-image: url(http://tutmee.ru/images/main-bg.jpg);background-repeat:repeat-y ;background-position: top center; border-spacing: 0; " cellspacing="0" cellpadding="0">
            <tr>
                <td>
                    <table style="margin: 0 auto; font-family: Tahoma" cellspacing="0" cellpadding="0">
                        <tr>
                            <td style="text-align: center; font-size: 30px;font-weight: 100; text-transform: uppercase;padding-top: 140px; padding-left: 40px;padding-right: 40px;">
                                <span >Спасибо</span>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: center; font-size: 30px;text-transform: uppercase;font-weight: 100;padding-bottom: 12px">
                                <span>за проявленный интерес</span>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: center; font-family: Tahoma; font-size: 18px; padding-bottom: 12px">
                                <span>мы с Вами свяжемся в ближайшее время</span>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <table style="font-family: Tahoma;border-top: 1px solid #C7C7C7;margin: 0 auto;width: 350px; height: 1px" cellspacing="0" cellpadding="0">
                    </table>
                    <table style="font-family: Tahoma;border-top: 1px solid #ffffff;margin: 0 auto;width: 350px; height: 1px" cellspacing="0" cellpadding="0">
                    </table>
                </td>
            </tr>
            <tr>
                <td style="text-align: center; padding-left: 40px;padding-right: 40px;text-align: center;font-family: Tahoma; font-size: 18px">
                    <span>С уважением, коллектив компании <span><strong>' . $_SERVER['SERVER_NAME'] . '</strong></span></span>
                </td>
            </tr>
            <tr>
                <td style="font-family:tahoma; padding-top: 20px; margin: 0;vertical-align: top">
                    <table style="width: 600px; margin: 0 auto" cellspacing="0" cellpadding="0">
                        <tr>
                            <td>
                                <table style=" margin: 0 auto;width: 179px;" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td style="text-align: center; padding-top: 0px">
                                            ' . $_SERVER['SERVER_NAME'] . '
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <table style="width: 600px; margin: 0 auto;background-image: url(http://tutmee.ru/images/t2-bg.jpg);background-repeat:  no-repeat; height: 457px;background-position: bottom center;" cellspacing="0" cellpadding="0" >
            <tr>
                <td style="vertical-align: bottom;">
                    <table style="width: 486px; border-bottom:1px solid #C7C7C7;margin: 0 auto; height: 1px" cellspacing="0" cellpadding="0" ></table>
                </td>
            </tr>
            <tr>
                <td style="vertical-align: top">
                    <table style="width: 486px; border-top:1px solid #ffffff;margin: 0 auto;" cellspacing="0" cellpadding="0">
                        <tr>
                            <td style="vertical-align: top;text-align: center; padding-top: 12px;">
//                                <a href="http://tutmee.ru/" style="text-align: left; font-size: 12px; font-family: Arial;color: #AAAAAA;text-decoration: none;display: inline-block;">
//                                    <img src="http://tutmee.ru/images/dev-logo.png" alt="TutMee Создание дизайна и разработка сайтов LTD Tutmee.ru"><br/>
//                                </a>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>';

		$mail = new PHPMailer();
		$mail->isSMTP();
		$mail->IsHTML(true);
		$mail->CharSet = "utf8";
		$mail->Host = "smtp.tutmee.ru";
		$mail->Port = 25;
		$mail->SMTPAuth = true;
		$mail->Username = "noreply@tutmee.ru";
		$mail->Password = "CsKHUvx9sya7mztZMzlO";
		$mail->setFrom($mail->Username);
		$mail->addAddress($_POST['email']);
		$mail->Subject = $thm;
		$mail->Body = $msg;
		if (!$mail->Send())
			die('Mailer Error: ' . $mail->ErrorInfo);
	}
}