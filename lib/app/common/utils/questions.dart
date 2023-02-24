import '../../services/auth_service.dart';

const question1 = 'Which network you were using?';
const question2 = 'Was the stream/picture quality pixelated and lagging?';
const question3 = 'Do you already own a gaming pc or laptop or console?';
const question4 = 'Was the picture/stream freezing?';
const question5 = 'Are you active gamer playing more than 40 hours per month?';
const question6 = 'Do you have internet with more 50Mbps speed?';
const question7 = 'Will you refer Oneplay to your friends?';
const question8 = 'What you loved the most?';

const List<String> answer1 = ['5G', 'Wifi 2.4ghz', 'Others'];
const List<String> answer2 = ['Yes', 'No'];
const List<String> answer3 = ['Quality', 'Value of money'];

// Refer urls...

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
