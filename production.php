<?php
    session_start();
?>

<html>

    <div class="off">
        <div>
            <h2></h2>
            <div id="confirmButtons" class="off">
                <input type="button" value="Yes">
                <input type="button" value="No">
            </div>
        </div>
        
    </div>

  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>M&H: Intranet CT</title>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@900&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="production.css">
    <script src="production.js" defer></script>

  </head>

  <body>
    <header>
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
                    <a><img src="login.png">
                        <?php if(isset($_SESSION["username"])) { echo $_SESSION['name']; } else { echo "SignIn"; } ?>
                    </a>
                </div>
              </h2>
          
        </nav>  

    </header>

    <section>
        <div id="user" class="off">
                <?php if(!isset($_SESSION["username"])) {
                    echo "<form name='login' method='POST' action='home_user.php'>
                            <input type='hidden' name='send' value='production'>
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
        <div id="menu">
            <h3>Production</h3>
            <div>
                <a>Last Results</a>
                <a>Manage Machines</a>
                <a>Manage Lots</a>
                <a>Week News</a>
            </div>
        </div>

        <div class="manage">
            <div id="title_window">
                <?php
                    if (!empty($_GET["send"])) {
                        echo " <h1>".$_GET["send"]."</h1>";
                    }
                ?>
            </div>
            <?php
                if (!empty($_SESSION["username"])) {
                    echo "<div class='off'>
                            <h2>Search</h2>
                            <h2>Create</h2>
                            <h2>Locate</h2>
                        </div>

                        <form name='search' class='off'>
                            <div>
                                <div>
                                    <label for='lot'>Lot ID</label>
                                    <input type='text' name='lot' value=''>
                                </div>
                                <div>
                                    <label for='product'>Product</label>
                                    <select name='product'>
                                        <option class ='choice' value='' selected='selected' hidden></option>
                                        <option value='rfsl'>RFSL</option>
                                        <option value='mrgl'>MRGL</option>
                                        <option value='ssll'>SSLL</option>
                                        <option value='euio'>EUIO</option>
                                    </select>
                                </div>
                                <div>
                                    <label for='flag'>Flag</label>
                                    <select name='flag'>
                                        <option class ='choice' value='' selected='selected' hidden></option>
                                        <option value='7'>7</option>
                                        <option value='d'>D</option>
                                    </select>
                                </div>    
                                <input type='submit' value='Search'> 
                                <input type='button' name='clear' value='Clear'> 
                            </div>
                        </form>

                        <form name='create' class='off'>
                            <div>
                                <div>
                                    <label for='lot'>Lot ID</label>
                                    <input type='text' name='lot' value=''>
                                </div>
                                <div>
                                    <label for='product'>Product</label>
                                    <select name='product'>
                                        <option class ='choice' value='' selected='selected' hidden></option>
                                        <option value='rfsl'>RFSL</option>
                                        <option value='mrgl'>MRGL</option>
                                        <option value='ssll'>SSLL</option>
                                        <option value='euio'>EUIO</option>
                                    </select>
                                </div>
                                <div>
                                        <label for='n_wfs'>N° WFS</label>
                                        <input type='number' name='n_wfs' min='1' max='24'>
                                    </div>
                                
                                <input type='submit' value='Confirm'>
                                <input type='button' name='clear' value='Clear'> 
                            </div>
                        </form>

                        <h3 class='off'></h3>

                        <table class='off'>
                            <thead>
                                <tr>
                                    <td>Series</td>
                                    <td>Product</td>
                                    <td>Quantity</td>
                                    <td>Flag</td>
                                    <td>Drop</td>
                                </tr>
                            </thead>
                            <tbody> </tbody>
                        </table>";
                }  
            ?>
        </div>  
      
    </section>

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