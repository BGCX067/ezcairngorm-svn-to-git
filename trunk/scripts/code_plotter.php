<?php

$src_code_path = $argv[1];
$dst_code_path = $argv[2];

if(is_dir($src_code_path)) 
{
  $files = scandir($src_code_path); 
  foreach($files as $file)
  {
    if(!preg_match('/^code/', $file)) continue;

    $src_fp = fopen($src_code_path . '\\' . $file, 'r');
    $dst_fp = null;
    $buffer = "";
    
    while (!feof($src_fp)) 
    {
        $str = fgets($src_fp);
        if(preg_match('/^###separator### (.+)/', $str, $m))
        {
          if(null != $dst_fp)
          {
              fwrite($dst_fp, $buffer);
              $dst_fp = null;
              $buffer = "";
          }
          
          $path_tokens = explode('.', $m[1]);
          array_walk($path_tokens, create_function('&$v,$k', '$v = trim($v);'));
          $path_tokens = array_chunk($path_tokens, sizeof($path_tokens)-2);
          $dst_path = $dst_code_path;
          
          for($i = 0 ; $i < sizeof($path_tokens[0]) ; $i++)
          {
            $dst_path .= '\\' . $path_tokens[0][$i];
            if(!is_dir($dst_path))
            {
              echo "Create directory {$dst_path}\n";
              mkdir($dst_path, 0777);
            }    
          }
          
          $dst_file = $dst_path . '\\' . implode('.', $path_tokens[1]);
          echo "Create file {$dst_file}\n";

          $dst_fp = fopen($dst_file, 'w');         
        }
        else
        {
          $buffer .= $str;
        }
    }
    
    if(null != $dst_fp)
    {
        fwrite($dst_fp, $buffer);
        $dst_fp = null;
        $buffer = "";
    }
  }
  
} 
else 
{
    exit("Failed to open {$src_code_path}");
}

?>
