
<html>
 <head>
  <title>Password generator</title>
  <meta http-equiv="refresh" content="5">
 </head>
 <body>
 <?php
 $old_path = getcwd();
 chdir('/var/www/html/');
 $output = shell_exec('./genpasswd.sh');
 chdir($old_path);
 echo $output; 
 ?>
 </body>
</html>
