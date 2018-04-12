create or replace 
type body ut_external_coverage as
  /*
  utPLSQL - Version X.X.X.X
  Copyright 2016 - 2017 utPLSQL Project

  Licensed under the Apache License, Version 2.0 (the "License"):
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
  */

  constructor function ut_external_coverage(
    self in out nocopy ut_external_coverage, a_coverage_id integer, a_description varchar2 := null, a_path varchar2
  ) return self as result is
  begin
    self.self_type := $$plsql_unit;
    self.coverage_id := a_coverage_id;
    self.init('', '', '', a_description, a_path, ut_utils.gc_rollback_auto, false);
    return;
  end;

  constructor function ut_external_coverage(
    self in out nocopy ut_external_coverage, a_path varchar2
  ) return self as result is
    l_path varchar2(4000); 
    l_runid integer;
  begin
    l_path := regexp_substr(a_path, '[:=](\d+)', subexpression => 1);
    l_runid := cast(l_path as integer);
    self.self_type := $$plsql_unit;
    self.coverage_id := l_runid;
    self.init('', '', '', 'ext coverage', l_path, ut_utils.gc_rollback_auto, false);
    return;  
  end;

  overriding member procedure mark_as_skipped(self in out nocopy ut_external_coverage, a_listener in out nocopy ut_event_listener_base) is
  begin
    null;
  end;

  overriding member function do_execute(self in out nocopy ut_external_coverage, a_listener in out nocopy ut_event_listener_base) return boolean is
  begin
    ut_utils.debug_log('ut_external_coverage.execute');
    ut_coverage_helper.set_coverage_id(coverage_id);
    return true;
  end;

  overriding member procedure calc_execution_result(self in out nocopy ut_external_coverage) is
  begin
    self.result := ut_utils.gc_success;
  end;

  overriding member procedure mark_as_errored(self in out nocopy ut_external_coverage, a_listener in out nocopy ut_event_listener_base, a_error_stack_trace varchar2) is
  begin
    null;
  end;

  overriding member function get_error_stack_traces return ut_varchar2_list is
  begin
    return ut_varchar2_list();
  end;

  overriding member function get_serveroutputs return clob is
  begin
    return null;
  end;

  overriding member function get_transaction_invalidators return ut_varchar2_list is
  begin
    return self.transaction_invalidators;
  end;
  
  member procedure add_profiler_units_to(self in out nocopy ut_external_coverage, a_names in out nocopy ut_object_names) is
  begin
    SELECT ut_object_name(unit_owner, unit_name)
     BULK COLLECT INTO a_names
     FROM plsql_profiler_units
    WHERE runid = self.coverage_id;
  end;
  
  static function is_external(path varchar2) return boolean is
  begin
    return regexp_like(path, '^((ext(ernal)?_)?coverage|run-?id)[:=]', 'i');
  end;

end;
/