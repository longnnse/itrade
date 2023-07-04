import 'package:intl/intl.dart';

class FormatDateTime {
  static String getDateFormat(String date) {
    String content;
    if (date != '') {
      if(date.contains('T')){
        if(date.contains('/')){
          content = date.split('T')[0];
        }else{
          content = '${date.split('T')[0].split('-')[2]}/${date.split('T')[0].split('-')[1]}/${date.split('T')[0].split('-')[0]}';
        }
      }else{
        if(date.contains('/')){
          content = date.split(' ')[0];
        }else{
          content = '${date.split(' ')[0].split('-')[2]}/${date.split(' ')[0].split('-')[1]}/${date.split(' ')[0].split('-')[0]}';
        }
      }
    }else{
      content = '';
    }
    return content;
  }

  static String getDateTimeFormat(String date){
    return "$getHourFormat(date) $getDateFormat(date)";
  }

  static String getDateFormatService(String date) {
    String content;
    if (date != '') {
      if(date.contains('T')){
        if(date.contains('/')){
          content = date.split('T')[0];
        }else{
          content = '${date.split('T')[0].split('-')[1]}/${date.split('T')[0].split('-')[2]}/${date.split('T')[0].split('-')[0]}';
        }
      }else{
        if(date.contains('/')){
          content = date.split(' ')[0];
        }else{
          content = '${date.split(' ')[0].split('-')[1]}/${date.split(' ')[0].split('-')[2]}/${date.split(' ')[0].split('-')[0]}';
        }
      }
    }else{
      content = '';
    }
    return content;
  }

  static String getHourFormat(String date) {
    String content;
    if (date != '') {

      if(date.contains('T')){
        content = '${date.split('T')[1].split(':')[0]}:${date.split('T')[1].split(':')[1]}';
      }else{
        content = '${date.split(' ')[1].split(':')[0]}:${date.split(' ')[1].split(':')[1]}';
      }
    }else{
      content = '';
    }
    return content;
  }
}
