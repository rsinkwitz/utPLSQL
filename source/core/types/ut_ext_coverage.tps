create or replace 
type ut_ext_coverage under ut_suite_item (
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

  /**
  * The run id to use for coverage 
  */
  coverage_id        integer,

  constructor function ut_ext_coverage(
    self in out nocopy ut_ext_coverage,a_coverage_id integer, a_description varchar2 := null, a_path varchar2
  ) return self as result,
  constructor function ut_ext_coverage(
    self in out nocopy ut_ext_coverage, a_path varchar2
  ) return self as result,
  overriding member procedure mark_as_skipped(self in out nocopy ut_ext_coverage, a_listener in out nocopy ut_event_listener_base),
  overriding member function  do_execute(self in out nocopy ut_ext_coverage, a_listener in out nocopy ut_event_listener_base) return boolean,
  overriding member procedure calc_execution_result(self in out nocopy ut_ext_coverage),
  overriding member procedure mark_as_errored(self in out nocopy ut_ext_coverage, a_listener in out nocopy ut_event_listener_base, a_error_stack_trace varchar2),
  overriding member function get_error_stack_traces return ut_varchar2_list,
  overriding member function get_serveroutputs return clob,
  overriding member function get_transaction_invalidators return ut_varchar2_list,
  member procedure addProfilerUnitsTo(a_names in out ut_object_names)
) not final
/
