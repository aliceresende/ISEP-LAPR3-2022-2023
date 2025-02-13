/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package app.utils;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * The type Utils.
 */
public class Utils
{
    /**
     * Read line from console string.
     *
     * @param strPrompt the str prompt
     * @return the string
     */
    static public String readLineFromConsole(String strPrompt)
    {
        try
        {
            System.out.println("\n" + strPrompt);

            InputStreamReader converter = new InputStreamReader(System.in);
            BufferedReader in = new BufferedReader(converter);

            return in.readLine();
        } catch (Exception e)
        {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Read long from console long.
     *
     * @param strPrompt the str prompt
     * @return the long
     */
    static public long readLongFromConsole(String strPrompt)
    {
        do {
            try {
                String strLong = readLineFromConsole(strPrompt);

                assert strLong != null;
                return Long.parseLong(strLong);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } while(true);
    }

    /**
     * Read integer from console int.
     *
     * @param strPrompt the str prompt
     * @return the int
     */
    static public int readIntegerFromConsole(String strPrompt)
    {
        do
        {
            try
            {
                String strInt = readLineFromConsole(strPrompt);

                assert strInt != null;
                return Integer.parseInt(strInt);
            } catch (NumberFormatException ex)
            {
                Logger.getLogger(Utils.class.getName()).log(Level.SEVERE, null, ex);
            }
        } while (true);
    }

    /**
     * Read double from console double.
     *
     * @param strPrompt the str prompt
     * @return the double
     */
    static public double readDoubleFromConsole(String strPrompt)
    {
        do
        {
            try
            {
                String strDouble = readLineFromConsole(strPrompt);

                assert strDouble != null;
                return Double.parseDouble(strDouble);
            } catch (NumberFormatException ex)
            {
                Logger.getLogger(Utils.class.getName()).log(Level.SEVERE, null, ex);
            }
        } while (true);
    }

    /**
     * Confirm boolean.
     *
     * @param sMessage the s message
     * @return the boolean
     */
    static public boolean confirm(String sMessage) {
        String strConfirm;
        do {
            strConfirm = Utils.readLineFromConsole("\n" + sMessage + "\n");
        } while (!strConfirm.equalsIgnoreCase("y") && !strConfirm.equalsIgnoreCase("n"));

        return strConfirm.equalsIgnoreCase("y");
    }

    /**
     * Show and select index int.
     *
     * @param list    the list
     * @param sHeader the s header
     * @return the int
     */
    static public int showAndSelectIndex(List list, String sHeader)
    {
        showList(list,sHeader);
        return selectIndex(list);
    }

    /**
     * Show list.
     *
     * @param list    the list
     * @param sHeader the s header
     */
    static public void showList(List list, String sHeader)
    {
        System.out.println(sHeader);

        int index = 0;
        for (Object o : list)
        {
            index++;

            System.out.println(index + ". " + o.toString());
        }
    }

    /**
     * Select index int.
     *
     * @param list the list
     * @return the int
     */
    static public int selectIndex(List list)
    {
        String opcao;
        int nOpcao;
        do
        {
            opcao = Utils.readLineFromConsole("Introduza opção: ");
            assert opcao != null;
            nOpcao = Integer.parseInt(opcao);
        } while (nOpcao < 0 || nOpcao > list.size());

        return nOpcao - 1;
    }

    /**
     * Is null boolean.
     *
     * @param obj the obj
     * @return the boolean
     */
    public static boolean isNull(Object obj) {
        return obj == null;
    }
}