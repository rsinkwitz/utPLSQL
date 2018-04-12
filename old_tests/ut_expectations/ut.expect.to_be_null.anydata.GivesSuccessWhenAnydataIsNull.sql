PROMPT Gives a success when the Anydata argument is null
--Arrange
declare
  l_result   integer;
begin
--Act
  ut.expect( cast(null as anydata) ).to_be_null();
  l_result :=  ut_expectation_processor.get_status();
--Assert
  if l_result = ut_utils.gc_success then
    :test_result := ut_utils.gc_success;
  else
    dbms_output.put_line('expected: '''||ut_utils.gc_success||''', got: '''||l_result||'''' );
  end if;
end;
/
