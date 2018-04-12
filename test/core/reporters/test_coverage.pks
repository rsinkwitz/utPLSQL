create or replace package test_coverage is

  --%suite
  --%suitepath(utplsql.core.reporters)

  --%beforeall
  procedure setup_dummy_coverage;

  --%afterall
  procedure cleanup_dummy_coverage;


  --%test(Coverage is gathered for specified object)
  procedure coverage_for_object;

  --%test(Coverage is gathered for specified object in the schema defined by run path)
  procedure coverage_for_object_no_owner;

  --%test(Coverage is gathered for specified schema)
  procedure coverage_for_schema;

  --%test(Coverage is gathered for specified file)
  procedure coverage_for_file;

  --%test(Coverage data is not cached between runs - issue #562 )
  --%aftertest(setup_dummy_coverage)
  procedure coverage_tmp_data_refresh;

end;
/
