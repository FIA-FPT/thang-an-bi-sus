init python:
    def getPassAndCheck():
        import hashlib
        input = renpy.input("Vậy đáp án của câu hỏi hồi nãy là gì?")
        hashedInput = hashlib.md5(input.encode())   
        return hashedInput.hexdigest() == 'c1d11ee283fddfe01a056e180a0b46c6'
 