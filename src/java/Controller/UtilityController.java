package Controller;

import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class UtilityController {

    //This is to convert Java DateTime String into SQL readable String Format (YYYY-MM-DD h:m:s) e.g:2016-01-04 23:34:09
    public static String convertSQLDateTimeString(Date date) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return "'" + sdf.format(date) + "'";
    }

    public static int convertStringtoInt(String numberStr) {
        int number = 0;
        try {
            number = Integer.parseInt(numberStr);
        } catch (Exception e) {

        }
        return number;
    }

    public static double convertStringtoDouble(String numberStr) {
        double number = 0.0;
        try {
            number = Double.parseDouble(numberStr);
        } catch (Exception e) {

        }
        return number;
    }

    public static String convertIntToString(int number) {
        String numberStr = "";
        try {
            numberStr = Integer.toString(number);
        } catch (Exception e) {
            numberStr = "error";
        }
        return numberStr;
    }

    public static boolean checkNullStringArray(String[] stringArray) {
        for (String str : stringArray) {
            if (str == null) {
                return true;
            }
        }
        return false;
    }

    public static String convertDoubleToCurrString(double money) {
        //NumberFormat formatter = NumberFormat.getCurrencyInstance();
        DecimalFormat df = new DecimalFormat("0.00");
        String moneyString = "" + df.format(money);
        return moneyString;
    }

    public static String convertIntToCurrString(int money) {
        NumberFormat formatter = NumberFormat.getCurrencyInstance();
        String moneyString = formatter.format(money);
        return moneyString;
    }

    public static Date convertStringToDate(String date) {
        DateFormat format = new SimpleDateFormat("MMMM d, yyyy", Locale.ENGLISH);
        Date returnDate = null;
        try {
            returnDate = format.parse(date);
        } catch (ParseException ex) {
            Logger.getLogger(UtilityController.class.getName()).log(Level.SEVERE, null, ex);
        }
        return returnDate;
    }

    public static Date addDays(Date date, int days) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(Calendar.DATE, days); //minus number would decrement the days
        return cal.getTime();
    }

    public static boolean validateEmail(String email) {

        String regex = "^[\\w!#$%&'*+/=?`{|}~^-]+(?:\\.[\\w!#$%&'*+/=?`{|}~^-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,6}$";

        Pattern pattern = Pattern.compile(regex);

        Matcher matcher = pattern.matcher(email);
        
        return matcher.matches();
    }
}
