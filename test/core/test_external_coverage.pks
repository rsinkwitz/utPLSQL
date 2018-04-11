create or replace package test_external_coverage is

  --%suite(external_coverage)
  --%suitepath(utplsql.core)

  --%test(test if path 'runid:22' is external)
  procedure test_path_is_external;

  --%test(test if path 'runid' is not external)
  procedure test_path_is_not_external;

  --%test(test if path is null)
  procedure test_path_is_empty;
  
  --%test(test constructor, coverage id parsing, and execution)
  procedure test_execution;

end;
/
