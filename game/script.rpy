# The script of the game goes in this file.

# Declare characters used by this game. The color argument colorizes the
# name of the character.

define k = Character("Khang")
define a = Character("An")
# The game starts here.

label start:

    # Show a background. This uses a placeholder by default, but you can
    # add a file (named either "bg room.png" or "bg room.jpg") to the
    # images directory to show it.

    scene bg ite

    # This shows a character sprite. A placeholder is used, but you can
    # replace it by adding a file named "eileen happy.png" to the images
    # directory.

    show khang happy

    # These display lines of dialogue.

    k "Chào Tất Cả anh em CLB FIA, hôm nay mình quyết định nghiêm túc học SWE"

    $ random = glitchtext(100)
    k "Câu nay là câu [random]"
    ""
    $ random = glitchtext(100)
    k "[random]"
    $ random = glitchtext(100)
    k "[random]"
    $ random = glitchtext(100)
    k "[random]"
    $ random = glitchtext(100)
    k "[random]"
    hide khang happy
    scene black
    $ random = glitchtext(100)
    "[random]"
    $ random = glitchtext(100)
    "[random]"
    $ random = glitchtext(100)
    "[random]"
    $ random = glitchtext(100)
    "[random]"
    $ random = glitchtext(100)
    "[random]"
    $ random = glitchtext(100)
    "[random]"
    menu:
        "Thôi mệt, đi ngủ":
            jump post_sleep
        "Học Tiếp":
            $ valid = getPassAndCheck()
            if valid:
                jump post_correct_answer
            else :
                jump post_wrong_answer
        
    # This ends the game.

    return


label post_correct_answer:
    scene an dau buoi 
    $ random = glitchtext(100)
    a "Đúng rồi, Giỏi quá bạn ơiiiii flag là [random]" 
    $ createFlag()
    pause 5.0
    $ restart()
label post_wrong_answer:
    scene an dau buoi
    a "Sai con mẹ nó rồi, Tôi xóa System32 của bạn đây :( "
    pause 5.0
    $ restart()
label post_sleep:
    scene an dau buoi 
    a "Không, tôi restart máy bạn"
    pause 5.0
    $ restart()