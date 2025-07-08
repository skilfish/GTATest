var djump = {
  highscore : 0,
  username: "",
}

djump.show = function() {
    ShowHomebar()
    
    $("#doodlejump").animate({
        "left": "0%"
    })
    
    Main.openapp = "djump"
    $("#phone-homebar").addClass("black")

}

$(function() {
    window.addEventListener("message", function(event) {
        var v = event.data;

        if (v.app == "jump" && v.task == "loadtop5") {
           $(".doodlerrankings").html(v.html)
        }  else if (v.app == "jump" && v.task == "setdata") {
            djump.highscore = v.score
            djump.username = v.username
           $("#doodleusername").html(v.username)

         }  
    });

  
});



    const grid = document.querySelector(".doodlejump-grid")
    const doodler = document.createElement('div')
    let doodlerLeftSpace = 10
    let startPoint = 10
    let doodlerBottomSpace = startPoint
    let isGameOver = true

    let platformCount = 5

    let containerHeight = 60
    let containerWidth = 29

    let doodlerWidth = 5
    let doodlerHeight = 6
    let doodlerFallamount = 0.25
    let defaultdoodlerFallamount = 0.2
    doodlerLeftImg = "https://raw.githubusercontent.com/JasonMize/coding-league-assets/master/doodle-jump-doodler.png"
    doodlerRightImg ="https://raw.githubusercontent.com/JasonMize/coding-league-assets/master/doodle-jump-doodler-right.png"


    let platformstylewidth = 4.5
    let platformstyleheight = 1.5
    let platformFallspeed = 30
    let platformFallamount = 0.15
    let defaultplatformFallamount = 0.15

    let sound = true

    let unit = "vh"

    let platforms = []

    let upTimerId
    let downTimerId
    let leftTimeId
    let stopPlayermovemendId
    let movePaltformid
    
    let score = 0

    let isJumping = false
    let isGoingLeft = false
    let isGoingRight = false

    let difficultymultiply = 1

    function createDoodler() {
        grid.appendChild(doodler)
        doodler.classList.add('doodler')

        doodlerLeftSpace = platforms[0].left
        doodler.style.left = doodlerLeftSpace + unit
        doodler.style.bottom = doodlerBottomSpace + unit
        doodler.style.backgroundImage = "url(" + doodlerLeftImg+ ")"
    }
    let oldposition
    class Platform {
        constructor(newPlatBottom) {
            this.bottom = newPlatBottom

            let left = Math.abs(Math.random() * containerWidth - 7)
            let difference = Math.abs(left - oldposition)

            while (difference < 7) {
                left = Math.abs(Math.random() * containerWidth - 7)
                difference = Math.abs(left - oldposition)
            }

            this.left = left
            oldposition = left
            if (this.left < 2) {
                this.left += 2
            }

            this.visual = document.createElement('div')

            const visual = this.visual
            let random = Math.random() * 500
            this.brokeplatform = false
            this.moveplatform = false
            this.rightside = false
            this.broke = false
            if (random < (50 * difficultymultiply)) {
                visual.classList.add('moveplatform')
                this.moveplatform = true
            } if (random <  (100 * difficultymultiply) && random >= (50 * difficultymultiply)) {
                // visual.classList.add('brokerplatform')
                $(visual).addClass("brokerplatform")
               
                this.brokeplatform = true
            } else {
                visual.classList.add('platform')
            }
            
            visual.style.left = this.left + unit
            visual.style.bottom = this.bottom + unit
            grid.appendChild(visual)

            this.moveInterval
        }
    }
    
    function createPlatforms() {
        for (let i = 0; i < platformCount; i++) {
            let plateGap = containerHeight / platformCount
            let newPlatBottom = 10 + i * plateGap
            let newPlatform = new Platform(newPlatBottom)
            platforms.push(newPlatform)
        }
    }

    let startpoint2
    let gainscore = false
    function jump() {
        clearInterval(downTimerId)
        isJumping = true


        startpoint2 = startPoint + 18
        let counter = 0.5;
        upTimerId = setInterval(function() {
            counter = Math.abs(counter)
            let smooth = startpoint2 - doodlerBottomSpace
            doodlerBottomSpace += (((0.04 * smooth) + 0.1) * (counter))

            doodler.style.bottom = doodlerBottomSpace + unit
       
    
            if(doodlerBottomSpace > startpoint2) {
                fall()
            }
            
            if (gainscore == true) {
                score += 1
                if (score > 4000) {
                    difficultymultiply = score / 3000
                    if (difficultymultiply > 8) {
                        difficultymultiply = 8
                    }
                } else if (score > 2000) {
                    difficultymultiply = score / 2000
                } 
               
                ingameScore(score)
            }
           
     
            
        }, 0)


    }

    let lastplatform
    function fall() {
        clearInterval(upTimerId)
        isJumping = false
        downTimerId = setInterval(function () {
            
        doodlerBottomSpace -= (containerHeight - doodlerBottomSpace) / 150
        doodler.style.bottom = doodlerBottomSpace + unit

        if ( doodlerBottomSpace <= 0 && !isGameOver) {
            doodleplaySound(".diesound")
            gameOver()
        }

        platforms.forEach(platform => {
            if (
                (doodlerBottomSpace >= platform.bottom + platformstyleheight - 0.5) &&
                (doodlerBottomSpace <= platform.bottom + platformstyleheight) &&
                ((doodlerLeftSpace + 6) >= platform.left) &&
                (doodlerLeftSpace <= (platform.left + platformstylewidth)) &&
                (isJumping == false) && 
                (platform.broke == false)
            ) {
                if (platform.brokeplatform == true) {
                    $(platform.visual).addClass('brokerplatformanimation')
                    $(platform.visual).animate({
                        "margin-bottom": "-50%",
                    }, 500)
                    platform.broke = true
                    doodleplaySound(".brokesound")
                }  else {
                    doodleplaySound(".jumpsound")
                }

                startPoint = doodlerBottomSpace

                if (lastplatform == platform) gainscore = false
                if (lastplatform != platform) gainscore = true
                lastplatform = platform
                
                jump()
              ;
            }
        })

            


        }, 10)
    }

    function setGravity() {
        setInterval(function() {
            if (doodlerBottomSpace > 30) {

                doodlerBottomSpace -= 0.2
                startpoint2 -= 0.1
                doodler.style.bottom = doodlerBottomSpace + unit
    
                platforms.forEach(platform => {
                        
                    platform.bottom -= 0.1
                    let visual = platform.visual
                    visual.style.bottom = platform.bottom + unit
    
                    if (platform.bottom < 0.1) {
                        let firstPlatform = platforms[0].visual
                        if (platforms[0].moveplatform == true) {
                            firstPlatform.classList.remove('moveplatform')
                            firstPlatform.classList.remove('platform')
                        } else {
                            firstPlatform.classList.remove('platform')
                        }
                        platforms.shift()
                        let newPlatform = new Platform(containerHeight)
                        platforms.push(newPlatform)
                    }
                })
            }
        }, 0)
        
    }

    function gameOver() {
        if (!isGameOver) {
            isGameOver = true
            while(grid.firstChild) {
                grid.removeChild(grid.firstChild)
            }
            $(".doodlejump-grid").html("")
            
            for (let i = 0; i < platformCount; i++) {
                platforms.shift()
            }
            clearInterval(leftTimeId)
            clearInterval(stopPlayermovemendId)
            clearInterval(upTimerId)
            clearInterval(movePaltformid)
            endscreen(score)
        }
       
    }


    function control(e) {
        if (e.key === "ArrowLeft") {
            moveSpace = 0.25
            moveLeft()
        } else if (e.key === "ArrowRight") {
            moveSpace = -0.25
            moveLeft()
        }else if (e.key === "ArrowUp") {
            moveSpace = 0
            moveStraight()
        }
    }

    let moveSpace = 0.5
    function resetcontrol() {
        clearInterval(leftTimeId)
        clearInterval(stopPlayermovemendId)

        isGoingLeft = false


       stopPlayermovemendId = setInterval(function( ) {
            if (doodlerLeftSpace <= 0 ) {
                moveSpace = Math.abs(moveSpace) * -1
            } else if (doodlerLeftSpace >= (containerWidth - doodlerWidth) ) {
                moveSpace = Math.abs(moveSpace)
            } 
            doodlerLeftSpace -= moveSpace
            doodler.style.left = doodlerLeftSpace + unit
            moveSpace *= 0.9
        }, 20)
    }

    function moveLeft() {
        clearInterval(leftTimeId)
        clearInterval(stopPlayermovemendId)

        if (moveSpace > 0 ) {
            doodler.style.backgroundImage = "url(" + doodlerLeftImg + ")"
        } else {
            doodler.style.backgroundImage = "url(" + doodlerRightImg + ")"
        }
    
        leftTimeId = setInterval(function( ) {
            if (doodlerLeftSpace <= 0 ) {
                moveSpace = Math.abs(moveSpace) * -1
            } else if (doodlerLeftSpace >= (containerWidth - doodlerWidth) ) {
                moveSpace = Math.abs(moveSpace)
            } 
            isGoingLeft = true

            doodlerLeftSpace -= moveSpace
            doodler.style.left = doodlerLeftSpace + unit
        }, 10)
    }

    $(document).on('click', '.doodlejump-startbutton', function() {
        $(".doodlejump-startbutton").fadeOut(0)
        difficultymultiply = 1
        start()
    });

    $(document).on('click', '.doodlejump-backbutton', function() {
        $(".doodlejump-rankscreen").fadeOut(500)
        $(".doodlejump-settingsscreen").fadeOut(500)
        $(".doodlejump-startscreen").fadeIn(500)
        ShowBackButton(-6)
        $(".doodlejump-homebutton").fadeOut(500)
        $("#doodlejump-gameover").fadeOut(500)
    });

    function ShowBackButton(value) {
        $(".doodlejump-backbutton").animate({
            "left" : value + "vh"
        },500)
    }

    $(document).on('click', '.doodlejump-homebutton', function() {
        $(".doodlejump-rankscreen").fadeOut(500)
        $(".doodlejump-settingsscreen").fadeOut(500)
        ShowBackButton(-6)
        $(".doodlejump-homebutton").fadeOut(500)
        $("#doodlejump-gameover").fadeOut(500)
        $(".doodlejump-startscreen").fadeIn(500)
    });

    $(document).on('click', '.doodlejump-ranksbutton', function() {
        $(".doodlejump-rankscreen").fadeIn(500)
        $(".doodlejump-startscreen").fadeOut(500)
        ShowBackButton(1.5)
    });

    $(document).on('click', '.doodlejump-settings', function() {
        $(".doodlejump-settingsscreen").fadeIn(500)
        $(".doodlejump-startscreen").fadeOut(500)
        ShowBackButton(1.5)
    });

    $(document).on('click', '.doodlecheckbox', function() {
        var element = $(this)
        var state = false
        if (element.hasClass("doodlechecked")) {
            element.removeClass("doodlechecked")
        } else {
            element.addClass("doodlechecked")
            state = true
        }

        let action = element.parent().data("action")
        if ( action == "sound") {
            sound = state

            if (state == true) {
                $("#doodlejump-settingsscreen-volumeicon").addClass("fa-volume-high")
                $("#doodlejump-settingsscreen-volumeicon").removeClass("fa-volume-xmark")
            } else {
                $("#doodlejump-settingsscreen-volumeicon").removeClass("fa-volume-high")
                $("#doodlejump-settingsscreen-volumeicon").addClass("fa-volume-xmark")
            }
        }

    });

    function DoodleEndGame() {
        gameOver()
        $(".doodlejump-endscreen").fadeOut(0)
        $(".doodlejump-homebutton").fadeOut(0)
        $(".doodlejump-startbutton").fadeOut(0)
        showStartscreen()

    }

    function start() {
        if (isGameOver) {

            hideEndscreen()
            score = 0
            isGameOver = false
            startPoint = 10
            doodlerBottomSpace = startPoint
        } 
        $(".doodlejump-settingsscreen").fadeOut(0)
        $(".doodlejump-rankscreen").fadeOut(0)
        ShowBackButton(-6)
        setGravity()
        hideStartscreen()
        difficultymultiply = 1
        createPlatforms()
        createDoodler()
        jump() 
        movePaltformid = setInterval( moveplatform, 10)

        document.addEventListener('keydown', control)
        document.addEventListener('keyup', resetcontrol)
    }

    // attach Button
    function endscreen(score) {

        $("#doodlejump-ingamescore").hide(0)
        $(".doodlejump-endscreen").fadeIn(500)
        $("#doodlejump-score").html(score)

        $(".doodlejump-homebutton").fadeIn(50)
        
        
        if (score >= djump.highscore) {
            sendData("jump:newhighscore",{
                score: score
            })
            djump.highscore = score
            $("#doodlejump-score").addClass("newhighscore")
        } else {
            $("#doodlejump-score").removeClass("newhighscore")
        }
        difficultymultiply = 1

        $("#doodlejump-highscore").html(djump.highscore)
        $(".doodlejump-startbutton").fadeIn(500)
    }

    function hideEndscreen() {
        $(".doodlejump-endscreen").fadeOut(500)
        $(".doodlejump-homebutton").fadeOut(500)
        $(".doodlejump-startbutton").fadeOut(500)

    }

    function hideStartscreen() {
        $(".doodlejump-startscreen").fadeOut(0)
        $(".doodlejump-startbutton").fadeOut(500)

    }

    function showStartscreen() {
        $(".doodlejump-startscreen").fadeIn(0)
        $(".doodlejump-startbutton").fadeIn(500)

    }

    function ingameScore(score) {
        $("#doodlejump-ingamescore").show(0)
        $("#doodlejump-ingamescore").html(score)
    }

    function doodleplaySound(file) {
        if (sound == true) {
            $(file).trigger('play');
        }
    }

    function moveplatform() {
        platforms.forEach(platform => {
            if (platform.moveplatform == true) {
                if (platform.rightside == true) platform.left -= (0.05 * difficultymultiply)
                if (platform.rightside == false) platform.left += (0.05 * difficultymultiply)
                
                if (platform.left >= (containerWidth - platformstylewidth)) {
                    platform.rightside = true
                }
                if (platform.left < 0) {
                    platform.rightside = false
                }
                let visual = platform.visual
                visual.style.left = platform.left + unit
            }
        });
    }

    // start()


$(document).on('click', '#doodleusernamebutton', function() {
    var name = $("#doodleusernameinput").val();

    var okay = CheckStringLength(name)

    if (okay == false) return

    sendData("jump:changename",{
        name: name
    })

    $("#doodleusername").html(name)
});