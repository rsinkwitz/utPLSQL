create or replace package body test_external_coverage is

  procedure test_path_is_external is
  begin
    ut.expect(ut3.ut_external_coverage.is_external('runid:22')).to_(be_true());
  end;

  procedure test_path_is_not_external is
  begin
    ut.expect(ut3.ut_external_coverage.is_external('runid')).to_(be_false());
  end;

  procedure test_path_is_empty is
  begin
    ut.expect(ut3.ut_external_coverage.is_external(null)).to_(be_null());
  end;
  
  procedure test_execution is
    l_external_coverage ut3.ut_external_coverage;
    l_listener ut3.ut_event_listener := ut3.ut_event_listener(ut3.ut_reporters());
    l_result boolean;
  begin
    l_external_coverage := ut3.ut_external_coverage('runid:22');
    l_result := l_external_coverage.do_execute(l_listener);
    ut.expect(l_external_coverage.coverage_id).to_(equal(22));
  end;

end;
/
