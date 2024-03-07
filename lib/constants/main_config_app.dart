class MainConfigApp {

  //Main
  static String appName = 'GitHub Search';


  static const String fontFamily1 = 'Roboto'; 



  ///Вот тут можете редактировать вид API
  static const DataSourceType dataSourceType = DataSourceType.graphQL;
}


enum DataSourceType{
  rest,
  graphQL
}


