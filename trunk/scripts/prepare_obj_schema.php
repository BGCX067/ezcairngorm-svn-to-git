<?php

require_once('inflect.class.php');

$file_to_prepare = $argv[1];

$data = simplexml_load_file($file_to_prepare);

foreach($data->object as $obj)
{
  echo $singularized_name = Inflect::singularize((string)$obj->attributes()->name);
  $tokens = create_tokens($singularized_name); 

  // notseparated lowercase
  $obj->addAttribute('name_ns_lc', build_name($tokens, 'ns_lc'));
  
  // underline_separated lowercase
  $obj->addAttribute('name_us_lc', build_name($tokens, 'us_lc'));
  
  // UNDERLINE_SEPARATED uppercase
  $obj->addAttribute('name_us_uc', build_name($tokens, 'us_uc'));
  
  // camelCase lower-first
  $obj->addAttribute('name_cc_lf', build_name($tokens, 'cc_lf'));
  
  // CamelCase upper-first
  $obj->addAttribute('name_cc_uf', build_name($tokens, 'cc_uf'));
  
  foreach($obj as $field)
  {
    $tokens = create_tokens((string)$field->attributes()->name);
    $field->addAttribute('name_us_lc', build_name($tokens, 'us_lc'));
    $field->addAttribute('name_cc_lf', build_name($tokens, 'cc_lf'));
  }
}

file_put_contents($file_to_prepare, $data->asXML());


function create_tokens($str)
{
  $tokens = array();
  $token = "";
  
  for($i = strlen($str)-1; $i >= 0  ; $i--)
  {
      $char = $str{$i};
      $token = $char . $token;    
  
      if(preg_match('/^[A-Z|_]/', $token) || $i == 0)
      {
          array_push($tokens, strtolower(trim($token, '_')));
          $token = "";
      }
  }
  return array_reverse($tokens);
}

/**
 * Possible $mode value for this function
 *  
 * ns_lc notseparated lowercase
 * us_lc underline_separated lowercase
 * us_uc UNDERLINE_SEPARATED uppercase
 * cc_lf camelCase lower-first
 * cc_uf CamelCase upper-first
 */   
  
function build_name($tokens, $mode)
{
    if('ns_lc' == $mode)
    {
      return implode("", $tokens);
    }
    else if('us_lc' == $mode)
    {
      return implode("_", $tokens);
    }
    else if('us_uc' == $mode)
    {
      array_walk($tokens, create_function('&$v,$k', '$v = strtoupper($v);'));
      return implode("_", $tokens);
    }
    else if('cc_lf' == $mode)
    {
      array_walk($tokens, create_function('&$v,$k', '0 != $k ? $v = ucfirst($v) : true;'));
      return implode("", $tokens);    
    }
    else if('cc_uf' == $mode)
    {
      array_walk($tokens, create_function('&$v,$k', '$v = ucfirst($v);'));
      return implode("", $tokens);     
    }           
}

?>
