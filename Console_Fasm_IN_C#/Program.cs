using System;
using System.Runtime.InteropServices;

namespace Console_Fasm_IN_C_
{
    internal class Program
    {
        [DllImport("ASM64Proj.dll")]
        public static extern void write_consol(string fmt, string msg);

        [DllImport("ASM64Proj.dll")]
        public static extern void write_consol(string fmt, int msg);

        //============================================================
        [DllImport("ASM64Proj.dll")]
        public static extern void write_consol_line(string fmt, int msg);

        [DllImport("ASM64Proj.dll")]
        public static extern void write_consol_line(string fmt, string msg);

        //---------------------------------------------------------------

        [DllImport("ASM64Proj.dll")]
        public static extern void wait_time(int time);

        [DllImport("ASM64Proj.dll")]
        public static extern void MyProc();


        [DllImport("ASM64Proj.dll")]
        public static extern int sum(int num1, int num2);


        [DllImport("ASM64Proj.dll")]
        public static extern void gnome_sortInt64(Int64[] rcx, Int64 rdx);


        static void Main()
        {

            Int64[] array = { 9, 8, 7, 6, 5, 4, 3, 2, 1, 0 };
            write_consol_line("%s", "Function 1>");

            gnome_sortInt64(array, array.Length);

            for (int i = 0; i < array.Length; i++)
            {
                Console.Write(array[i] + " || ");
            }

            write_consol_line("\nArray Lenght< %d", array.Length);


            wait_time(1000);
            write_consol_line("\n%s", "Function 2>");

            write_consol("%s", "\nMySumFunc\n<");

            int number = sum(15, 15);

            write_consol_line("%d", number);

            write_consol_line("\n%s", "Function 3>");

            write_consol_line("%s", "\nWhat is your name?");

            wait_time(1500);

            write_consol("%s", "<");

            write_consol_line("%s", "Hello " + Console.ReadLine() + "!");
        }
    }
}
