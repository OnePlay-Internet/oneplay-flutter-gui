// Refer urls...

import '../../services/auth_service.dart';

const subject = 'OnePlay game!!';
const text = 'OnePlay game...';

const facebookLink = 'https://www.facebook.com/sharer/sharer.php?u=';
const messangerLink = 'https://www.facebook.com/sharer/sharer.php?u=';
const whatsappLink = 'https://wa.me/?text=';
const twitterLink = 'http://twitter.com/?status=';
const telegramLink = 'https://telegram.me/share/url?url=';
const linkedinLink = 'https://www.linkedin.com/shareArticle?url=';
const emailLink = 'mailto:?subject=$subject&body=$text\n\n';

String referURL =
    'https://www.oneplay.in/dashboard/register?ref=${AuthService().userIdToken!.userId}';
