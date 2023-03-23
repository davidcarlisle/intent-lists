import re
import os
import sys
import libmathcat

if (len(sys.argv) != 2):
  raise Exception("no argument")

htmlfile=sys.argv[1]


def SetMathCATPreferences():
  try:
    libmathcat.SetRulesDir(
      # this assumes the Rules dir is in the same dir a the library. Modify as needed
      os.path.join( os.path.dirname(os.path.abspath(__file__)), "Rules")
    )
  except Exception as e:
    print("problem with finding the MathCAT rules")

  try:
    libmathcat.SetPreference("TTS", "none")
    libmathcat.SetPreference("Language", "en")         # Also "id" and "vi"
    libmathcat.SetPreference("SpeechStyle", "SimpleSpeak")   # Also "ClearSpeak"
    libmathcat.SetPreference("Verbosity", "Verbose")   # also terse "Terse"/"Medium"x
    libmathcat.SetPreference("CapitalLetters_UseWord", "false")   # if "true", X => "cap x"
    libmathcat.SetPreference("IntentErrorRecovery","Error") # Error and IgnoreIntent.
  except Exception as e:
      print("problem with setting a preference")

def SetMathMLForMathCAT(mathml: str):
    libmathcat.SetMathML(mathml)


def GetSpeech():
  libmathcat.SetPreference("IntentErrorRecovery","Error") # Error and IgnoreIntent.
  try:
    return libmathcat.GetSpokenText()
  except Exception as e:
      libmathcat.SetPreference("IntentErrorRecovery","IgnoreIntent") # Error and IgnoreIntent.
      s2=libmathcat.GetSpokenText()
      return "<span class='error' title='" + re.sub('apos;M[^& ]*','apos;M...',re.sub('C:.*?mathcat','mathcat',str(e)).replace('&','&amp;').replace('<','&lt;').replace("'",'&apos;')) + "'>" + s2 +"</span>"



SetMathCATPreferences()   # you only need to this once


htmlstr = open(htmlfile,'r',encoding="utf-8").read()
htmlstr = htmlstr.replace('<!--X','<').replace('X-->','>').replace('\t','        ')

mmltds=re.split(r'<tr>\s*<td>(\s*<math\b.*?</math>\s*)</td>\s*<td>(.*?)</td>', htmlstr, flags=re.DOTALL)


sys.stdout.reconfigure(encoding='utf-8')

i=0
for mmltd in mmltds:
  i=i+1
  if(i % 3 == 2):
    print("<tr>")
    print("<td>")
    print(mmltd)
    print("</td>")
  if(i % 3 == 2   or i % 3 == 0):
    print("<td>")
    mmls=re.split(r'(<math\b.*?</math>)',str(mmltd), flags=re.DOTALL)
    j=0
    for mml in mmls:
      j=j+1
      if(j % 2 == 0):
        print("<pre>")
        print(mml.replace('&','&amp;').replace('<','&lt;').replace('\n     ','\n'))
        print("</pre>")
        try:
          SetMathMLForMathCAT(mml)
          mcat=GetSpeech()
          mcatl=re.sub(r'((line|column|case) [0-9]+;)',r'<br/>\1',mcat)
          print ("\n    <div class=\"mathcat\">{}</div>".format(mcatl))
        except:
          print ("\n    <div class=\"mathcat\">problem with SetMathML</div>")
    print("</td>")
  else:
    print (mmltd,end="")
