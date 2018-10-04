using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Text;
using System.Windows.Forms;

namespace indiv
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        string path_to_file;
        string path_to_swipl = @"C:\Program Files (x86)\swipl\bin";
        string command = "";
        private void button1_Click(object sender, EventArgs e)
        {

            try
            {
                //создаем новый процесс, который будет работать с консолью
                Process pr = new Process();
                pr.StartInfo.FileName = path_to_swipl+ @"\swipl.exe";
                pr.StartInfo.Arguments = textBox2.Text;
                pr.StartInfo.UseShellExecute = false;
                //отключаем использование оболочки, чтобы можно было читать данные вывода
                //перенаправляем данные вовода
                pr.StartInfo.RedirectStandardOutput = true;
                //задаем кодировку, чтобы читать кириллические символы
                pr.StartInfo.StandardOutputEncoding = Encoding.GetEncoding(1251);
                pr.OutputDataReceived += new DataReceivedEventHandler(ConsoleOutputHandler);
                //запрещаем создавать окно для запускаемой программы                
                pr.StartInfo.CreateNoWindow = true;
                pr.Start();
                pr.BeginOutputReadLine();
            }
            catch (Exception error)
            {
                MessageBox.Show("Ошибка при запуске!\n" + error.Message, Application.ProductName, MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }
        private void ConsoleOutputHandler(object sendingProcess,DataReceivedEventArgs recieved)
        {
            if (!String.IsNullOrEmpty(recieved.Data))
            {

                MessageBox.Show(recieved.Data);

            }
        }
        private void openToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (!File.Exists(path_to_swipl + @"\swipl-win.exe"))
            {
                folderBrowserDialog1.ShowDialog();
                while(folderBrowserDialog1.SelectedPath!=null)
                {
                    folderBrowserDialog1.ShowDialog();
                }
                path_to_swipl = folderBrowserDialog1.SelectedPath;
            }
            string text_from_file = "";
            openFileDialog1.Filter = "Prolog files|*.pl";
            openFileDialog1.ShowDialog();
            if (openFileDialog1.FileName != null)
            {
                if (openFileDialog1.FileName != "")
                {
                    path_to_file = openFileDialog1.FileName.ToString();
                    text_from_file = File.ReadAllText(path_to_file);
                }
                for (int i = 0; i <= text_from_file.Length - 1; i++)
                {
                    if (text_from_file[i] == ':' && text_from_file[i + 1] == '-')
                    {
                        string predicate = "";
                        int i2 = i - 1;
                        if (i2 > 0)
                        {
                            while (text_from_file[i2] != '.')
                            {
                                predicate += text_from_file[i2];
                                i2--;
                            }
                        }
                        char[] inputarray = predicate.ToCharArray();
                        Array.Reverse(inputarray);
                        string predicate_r = new string(inputarray);
                        predicate_r = predicate_r.Replace((char)13, ' ');
                        predicate_r = predicate_r.Replace((char)10, ' ');
                        predicate_r = predicate_r.Trim(' ');
                        if (predicate_r != "")
                        {
                            listBox1.Items.Add(predicate_r);
                        }
                    }
                }
            }
        }

        private void listBox1_Click(object sender, EventArgs e)
        {
            listBox2.Items.Clear();
            listBox3.Items.Clear();
            string claus = listBox1.Items[listBox1.SelectedIndex].ToString();
            string[] s = claus.Split('(');
            command = s[0];
            s[1] = s[1].Trim(')');
            string[] s1 = s[1].Split(',');
            listBox2.Items.AddRange(s1);
            listBox3.Items.AddRange(s1);
            label2.Text = "";
            textBox2.Text = " -f " + path_to_file + " -g " + listBox1.Items[listBox1.SelectedIndex] + " -t halt";
        }

        private void listBox2_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (listBox2.SelectedIndex >= 0)
            {
                label3.Text = listBox2.SelectedItem.ToString() + "=";
                textBox1.Enabled = true;
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            if (textBox1.Text != null)
            {
                listBox3.Items[listBox2.SelectedIndex] = textBox1.Text;
                textBox2.Text = " -f " + path_to_file + " -g " + command + "(";
                for(int i = 0; i <= listBox3.Items.Count - 1; i++)
                {
                    textBox2.Text += listBox3.Items[i] + ",";
                }
                textBox2.Text = textBox2.Text.Remove(textBox2.Text.Length - 1, 1);
                textBox2.Text += ")" +  " -t halt";
            }
        }
    }
}
