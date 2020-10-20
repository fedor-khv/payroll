<html>
 <head>
  <title>сотрудники</title>
 </head>
 <body>
    <table>
        <tr>
            <th>имя</th>
            <th>фамилия</th>
            <th>отчество</th>
            <th>должность</th>
            <th>оклад</th>
            <th>отработано дней</th>
            <th>районный коэфф.</th>
            <th>премия (%)</th>
            <th>зарплата</th>
        </tr>
<?php
class DataBase {

  private static $db = null; // singlton
  private $sym_query = "{?}"; // "Символ значения в запросе"

  //создание экземпляра класса
  public static function getDB() {
    if (self::$db == null) self::$db = new DataBase();
    return self::$db;
  }

  //подключение к бд
  private function __construct() {
    $this->mysqli = new mysqli("localhost", "mysql", "mysql", "test");

  }

   //получение строки параметризованного запроса
   private function getQuery($query, $params) {
    if ($params) {
      for ($i = 0; $i < count($params); $i++) {
        $pos = strpos($query, $this->sym_query);
        $arg = "'".$this->mysqli->real_escape_string($params[$i])."'";
        $query = substr_replace($query, $arg, $pos, strlen($this->sym_query));
        }
    }
    return $query;
  }

  //SELECT
  public function select($query, $params) {
    $result_set = $this->mysqli->query($this->getQuery($query, $params));
    if (!$result_set) return false;
    return $this->resultSetToArray($result_set);
  }

  //метод получения значение ячейки
  public function selectCell($query, $params) {
    $result_set = $this->mysqli->query($this->getQuery($query, $params));
    if ((!$result_set) || ($result_set->num_rows != 1)) return false;
    else {
      $arr = array_values($result_set->fetch_assoc());
      return $arr[0];
    }
  }

  //остальные операторы SQL
  public function query($query, $params) {
    $success = $this->mysqli->query($this->getQuery($query, $params));
    if ($success) {
      if ($this->mysqli->insert_id === 0) return true;
      else return $this->mysqli->insert_id;
    }
    else return false;
  }

  /* Преобразование result_set в двумерный массив */
  private function resultSetToArray($result_set) {
    $array = array();
    while (($row = $result_set->fetch_assoc()) != false) {
      $array[] = $row;
    }
    return $array;
  }


  public function __destruct() {
    if ($this->mysqli) $this->mysqli->close();
  }
}

  $par = 1;//параметр запроса по индексу связующей таблици. может быть использован для навигации по таблице запроса.
  $db = DataBase::getDB();
  //$db = new DataBase ();

  //параметризованный запрос по таблице salary
  $query = "SELECT n.name1, n.name2, n.surname, s.p_ind, s.zp, s.rk, s.pk, s.total_day, p.position, p.salary  FROM salary s JOIN name n ON s.n_ind=n.n_id JOIN position p ON s.p_ind=p.p_id WHERE s.s_ind = {?}" ;
  $table = $db->select($query, array($par)); //
  //unset($db);
    $result = '';
        foreach ($table as $elem) {
            $result .= '<tr>';

            $result .= '<td>' . $elem['name1'] . '</td>';
            $result .= '<td>' . $elem['name2'] . '</td>';
            $result .= '<td>' . $elem['surname'] . '</td>';
            $result .= '<td>' . $elem['position'] . '</td>';
            $result .= '<td>' . $elem['salary'] . '</td>';
            $result .= '<td>' . $elem['total_day'] . '</td>';
            $result .= '<td>' . $elem['rk'] . '</td>';
            $result .= '<td>' . $elem['pk'] . '</td>';
            $result .= '<td>' . $elem['zp'] . '</td>';



            $result .= '</tr>';
        }


        echo $result;
    //$rows = 5;
    //echo 'количество строк '.$rows;

    //=======рассчет зарплаты==========
        $rk=$_POST['rk'];
        $pk=$_POST['pk'];
        //$td=15;//отработано дней
        //$salary=25000;
        $rdm=22;//количество рабочих дней в месяце;


        //получаем оклад
         $query1 = "SELECT p.salary  FROM salary s JOIN name n ON s.n_ind=n.n_id JOIN position p ON s.p_ind=p.p_id WHERE s.s_ind = {?}" ;
         $salary=$db->selectCell($query1,array($par));

         //получаем количество дней
         $query2 = "SELECT s.total_day  FROM salary s WHERE s.s_ind = {?}" ;
         $td = $db->selectCell($query2, array($par));

         //рассчет зарплаты
         $zp=round($salary*$rdm/$td*$rk*((100+$pk)/100),2);
         echo $zp;

         //обновление данных таблицы salary
         $queryUpd = "UPDATE `salary` SET `rk` = '".$rk."' , `pk` = '".$pk."' , `zp` = '".$zp."' WHERE `salary`.`s_ind` = {?}";

         $table = $db->query($queryUpd,array($par));


 ?>

        <form method="POST">
         <td>РК<input name="rk" maxlength=4 size=4></td>
         <td>ПК<input name="pk" maxlength=4 size=4></td>
         <td colspan=2><input type="submit" value="Рассчитать"></td>
        </form>
</table>
</body>
</html>



