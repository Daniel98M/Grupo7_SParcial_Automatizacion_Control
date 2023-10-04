PROGRAM exam_openPLC_simu
  VAR
    s1_arrive AT %IX0.0 : BOOL;
    s2_arrive AT %IX0.1 : BOOL;
    s3_bottle_full AT %IX0.2 : BOOL;
    s4_bottle_seal AT %IX0.3 : BOOL;
    start AT %IX0.4 : BOOL;
    bomb AT %QX0.0 : BOOL;
    Ms_down_up AT %QX0.1 : BOOL;
    M1_M2 AT %QX0.2 : BOOL;
  END_VAR
  VAR
    TON0 : TON;
  END_VAR

  IF start THEN
    M1_M2 := TRUE; (*set*)
  END_IF;
  IF s1_arrive THEN
    M1_M2 := FALSE; (*reset*)
  END_IF;
  IF s1_arrive THEN
    bomb := TRUE; (*set*)
  END_IF;
  IF s3_bottle_full THEN
    bomb := FALSE; (*reset*)
  END_IF;
  IF s3_bottle_full THEN
    M1_M2 := TRUE; (*set*)
  END_IF;
  IF s2_arrive THEN
    M1_M2 := FALSE; (*reset*)
  END_IF;
  IF s2_arrive THEN
    Ms_down_up := TRUE; (*set*)
  END_IF;
  TON0(IN := Ms_down_up, PT := T#1000ms);
  IF TON0.Q THEN
    Ms_down_up := FALSE; (*reset*)
  END_IF;
  IF s4_bottle_seal THEN
    M1_M2 := TRUE; (*set*)
  END_IF;
END_PROGRAM


CONFIGURATION Config0

  RESOURCE Res0 ON PLC
    TASK task0(INTERVAL := T#20ms,PRIORITY := 0);
    PROGRAM instance0 WITH task0 : exam_openPLC_simu;
  END_RESOURCE
END_CONFIGURATION
