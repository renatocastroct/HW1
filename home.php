<?php 
    session_start();
?>

<html>

  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>M&H: Intranet CT</title>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@900&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="home.css">
    
    <script src="home.js" defer></script>
  </head>

  <body>
    <header>
    <div id="overlay">
      <div id="title">
        <h1>M&H</h1>
        <h2>Microelectronics</h2>
        <h3>Intranet CT</h3>
      </div>

      <nav id="links">
        <h2>
          <a href="home.php"><img src="home.png">Home</a>
          <a href="statistics.php"><img src="statistics.png">Statistics</a>
          <a href="production.php"><img src="prod.png">Production</a>
          <a><img src="cards.png">Employees</a>
          <a><img src="tips.png">Tips</a>
          <div id="login">
            <a><img src='login.png'>
                <?php if(isset($_SESSION["username"])) { echo $_SESSION['name']; } else { echo "SignIn"; } ?>
            </a>
          </div>
        </h2>        
      </nav>

      <div id="main">

        <div id="sponsor">
            <div id="sponsor_1">
            <h3>Not</h3><h1>Hard</h1><h2>Work</h2>
            </div>
            <div id="sponsor_2">
            <h3>but</h3><h1>Quality</h1><h2>Work</h2>
            </div>
            <h4>is the way to success</h4>
        </div>

        <div id="user" class="off">
            <?php if(!isset($_SESSION["username"])) {
                echo "<form name='login' method='post' action='home_user.php'>
                      <input type='hidden' name='send' value='home'>
                        <div>
                            <input type='text' name='username' placeholder='username'>
                        </div>
                        <div>
                            <input type='password' name='password' placeholder='password'>
                        </div>
                        <!-- <div id='check'>
                            <input type='checkbox' name='remember' value='1'>
                            <label for='remember'>Remember me</label>
                        </div> -->
                        <div id='submit'>
                            <input type='submit' value='Login'>
                            <p>New User?</p>
                            <a href='signup.php'>SignUp</a>
                        </div>
                    </form>";
                }
            ?>
        </div>
      </div>
      
    </div>
    </header>
    <?php if(isset($_SESSION["username"])) {
            echo "<section id='highlights'>
                    <div id='machines'>
                      <div id='presentation'>
                          <h1>Department Info:</h1>
                          <input type='text' id='search' placeholder='Search'>
                      </div>
              
                      <div class='blocks'> </div>
                    </div>
                </section>";
            } else { 
                echo '<section>
                        <div class="highlights">
                            <img class="highlights" src="calendar.jpeg" />
                            <div id="comment1"> </div>
                        </div>
          
                        <div class="highlights">
                          <img class="highlights" src="results.jpeg" />
                          <div id="comment2"> </div>
                        </div>          
                      </section>';
                    }
    ?>
      
    <footer>
        <p>
          <h1>Design by Renato Castro - 1000011358</h1>
          <a><img src="twitter.png"></a>
          <a><img src="fb.png"></a>
          <a><img src="ig.png"></a>
          <a><img src="pinterest.png"></a>
          <address>Viale Mario Rapisardi, 140/144 - 95125 Catania (CT)</address>
        </p>
    </footer>
  </body>
</html>