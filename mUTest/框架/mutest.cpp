#include<cstdio>
#include<vector>
#include<string>
#include<fstream>
#include<iostream>
#include<cstring>
#include<algorithm>
#include <direct.h>
using namespace std;

vector<string> inputData,outputData,stdResult;
char buf[10000];

void readFile(string name,vector<string> &data)
{
    FILE *f=fopen(name.c_str(),"r");
    data.clear();
    for(char ch;;)
    {
        ch=fgetc(f);
        if (ch==EOF) break;
        if (ch=='\n') 
        {
            if (data.size() && data[data.size()-1].size())
                data.push_back("");
        } else
            if (ch==' ')
            {
                if (data.size() && data[data.size()-1].size()) data[data.size()-1]+=" ";
            } else
                if (ch>' ' && ch<=126) 
                {
                    if (!data.size()) data.push_back("");
                    data[data.size()-1]+=ch;
                }
    }
    while (data.size() && !data[data.size()-1].size()) data.pop_back();
    fclose(f);
}

void showResult(string funcName, string result)
{
    string tmp="result\\"+funcName+".txt";
    ofstream f(tmp.c_str());
    for (int i=0;i<inputData.size();i++)
        f << inputData[i] << endl << outputData[i] << endl << stdResult[i] << endl << result[i] << endl;
    f.close();
}

void testFunction(string funcName)
{
    //���� �����ļ�,����ļ�,����inputData,stdResult��
    string tmp="data\\"+funcName+".in";
    readFile(tmp,inputData);
    tmp="data\\"+funcName+".std";
    readFile(tmp,stdResult);

    //�������
    string cmd="E:\\mathmu\\build\\stage\\bin\\Debug\\mu < data\\"+funcName+".in > output\\" +funcName+".out";
    system(cmd.c_str());
    //��mu��������,����outputData��
    tmp="output\\"+funcName+".out";
    outputData.clear();
    ifstream out(tmp.c_str(),ifstream::in);
    do out>>tmp; while (tmp!="mU>");
    do
    {
        if (tmp=="mU>")
        {
            if (!outputData.size() || outputData[outputData.size()-1].size()) 
                outputData.push_back("");
        } else outputData[outputData.size()-1]+=" "+tmp;
    } while (out>>tmp);
    out.close();
    while (!outputData[outputData.size()-1].size()) outputData.pop_back();

    //����m�����Խ��
    tmp="mcode\\"+funcName+".m";
    ofstream mcode(tmp.c_str());
    tmp="data\\"+funcName+".std";
    FILE *stdOutput=fopen(tmp.c_str(),"r");
    mcode << "s={};\n";
    for (int i=0;i<outputData.size();i++)
        mcode << "s=Append[s,Equal["+outputData[i]+"," << stdResult[i] << "]];\n";
    char *lppath=new char[1000]();
    _getcwd(lppath,1000);
    mcode << "Export[\"";
    for (int i=0;lppath[i];i++)
        if (lppath[i]=='\\') mcode << "\\\\";
        else mcode << lppath[i];
    mcode << "\\\\mcode\\\\" << funcName << "_cmp.txt\",s,\"List\"];\n";
    mcode.close();
    fclose(stdOutput);

    //ͳ�ƽ��
    tmp="math < mcode\\"+funcName+".m";
    system(tmp.c_str());
    tmp="mcode\\"+funcName+"_cmp.txt";
    FILE *cmpResult=fopen(tmp.c_str(),"r");
    string result="";
    for (int i=0;i<outputData.size();i++)
    {
        fgets(buf,10000,cmpResult);
        result=result+(char)((buf[0]=='T' && buf[1]=='r' && buf[2]=='u' && buf[3]=='e' && (buf[4]=='\n' || buf[4]==0))+'0');
    }
    
    //������
    showResult(funcName,result);
}

int main()
{
    ifstream flist("FileList.txt",ifstream::in);
    vector<string> fileList;
    string tmp;
    while (flist >> tmp) fileList.push_back(tmp); 
    flist.close();
    for_each(fileList.begin(),fileList.end(),testFunction);
}
