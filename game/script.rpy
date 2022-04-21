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
            pass
    scene an dau buoi 
    a "Không, tôi restart máy bạn"
    pause 5.0
    $ restart()

    # This ends the game.

    return
