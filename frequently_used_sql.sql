-- Replication
call ttRepStop;

drop active standby pair;

create active standby pair repmaster on "timesten-hol.us.oracle.com", repstandby on "timesten-hol.us.oracle.com" return receipt by request;

call ttRepStateSet('ACTIVE');

call ttRepStart;

ttRepAdmin -duplicate -host "timesten-hol.us.oracle.com" -from repmaster -verbosity 2 -dsn repstandby -UID scott -PWD tiger

ttAdmin -repStart repstandby

ttAdmin -repStop repstandby

autocommit 0;

call ttRepSyncSet(0x01, 10);

commit;

call ttReplicationStatus;
