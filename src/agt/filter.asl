// Agent init in project erasto

/* Initial beliefs and rules */

child_agent_name(FInt, Name) :-
    .term2string(FInt, S) &
    .concat("filter", S, NameStr) &
    .term2string(Name, NameStr).


/* Plans */

@findPrimesInit[atomic]
+!find_primes_below_thres : threshold(Th)
    <- .log(info, "New prime number found: ", 1);

    // make first agent, filter = 2
    .log(info, "New prime number found: ", 2);
    ?child_agent_name(2, Child);
    .create_agent(Child, "filter.asl");
    +child(Child);
    .send(Child, tell, filter(2));
    .send(Child, tell, threshold(Th));

    for ( .range(I, 3, Th)) {
        .send(Child, process, I);
    }.


@kqmlReceivedProcess1[atomic]
+!kqml_received(KQML_Sender_Var, process, Num, KQML_MsgId)

    : filter(F) & Num mod F == 0 & threshold(Th) & .my_name(Me)

    <- if ( Num == Th ) { .kill_agent(Me); }.


@kqmlReceivedProcess2[atomic]
+!kqml_received(KQML_Sender_Var, process, Num, KQML_MsgId)

    : filter(F) & Num mod F > 0 & not child(_) & threshold(Th) & .my_name(Me)

    <- .log(info, "New prime number found: ", Num);

    ?child_agent_name(Num, Child);
    .create_agent(Child, "filter.asl");
    +child(Child);
    .send(Child, tell, filter(Num));
    .send(Child, tell, threshold(Th));

    if ( Num == Th ) { .kill_agent(Me); }.


@kqmlReceivedProcess3[atomic]
+!kqml_received(KQML_Sender_Var, process, Num, KQML_MsgId)

    : filter(F) & Num mod F > 0 & child(Child) & threshold(Th) & .my_name(Me)

    <- .send(Child, process, Num);
    if ( Num == Th ) { .kill_agent(Me); }.
