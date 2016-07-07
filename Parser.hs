{-# OPTIONS_GHC -w #-}
module Parser where
import Lexer
import Types
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.5

data HappyAbsSyn t4 t5 t6 t7 t8 t9 t10 t11 t12 t13 t14
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn4 t4
	| HappyAbsSyn5 t5
	| HappyAbsSyn6 t6
	| HappyAbsSyn7 t7
	| HappyAbsSyn8 t8
	| HappyAbsSyn9 t9
	| HappyAbsSyn10 t10
	| HappyAbsSyn11 t11
	| HappyAbsSyn12 t12
	| HappyAbsSyn13 t13
	| HappyAbsSyn14 t14

action_0 (16) = happyShift action_3
action_0 (4) = happyGoto action_4
action_0 (5) = happyGoto action_5
action_0 _ = happyFail

action_1 (16) = happyShift action_3
action_1 (5) = happyGoto action_2
action_1 _ = happyFail

action_2 _ = happyFail

action_3 (16) = happyShift action_8
action_3 (6) = happyGoto action_7
action_3 _ = happyReduce_4

action_4 (45) = happyAccept
action_4 _ = happyFail

action_5 (43) = happyShift action_6
action_5 _ = happyReduce_1

action_6 (16) = happyShift action_3
action_6 (4) = happyGoto action_11
action_6 (5) = happyGoto action_5
action_6 _ = happyFail

action_7 (21) = happyShift action_10
action_7 _ = happyFail

action_8 (16) = happyShift action_8
action_8 (6) = happyGoto action_9
action_8 _ = happyReduce_4

action_9 _ = happyReduce_5

action_10 (15) = happyShift action_14
action_10 (16) = happyShift action_15
action_10 (22) = happyShift action_16
action_10 (32) = happyShift action_17
action_10 (33) = happyShift action_18
action_10 (35) = happyShift action_19
action_10 (38) = happyShift action_20
action_10 (41) = happyShift action_21
action_10 (7) = happyGoto action_12
action_10 (8) = happyGoto action_13
action_10 _ = happyFail

action_11 _ = happyReduce_2

action_12 (15) = happyShift action_14
action_12 (16) = happyShift action_15
action_12 (17) = happyShift action_31
action_12 (18) = happyShift action_32
action_12 (19) = happyShift action_33
action_12 (20) = happyShift action_34
action_12 (24) = happyShift action_35
action_12 (25) = happyShift action_36
action_12 (26) = happyShift action_37
action_12 (27) = happyShift action_38
action_12 (28) = happyShift action_39
action_12 (29) = happyShift action_40
action_12 (30) = happyShift action_41
action_12 (31) = happyShift action_42
action_12 (38) = happyShift action_20
action_12 (41) = happyShift action_21
action_12 (8) = happyGoto action_30
action_12 _ = happyReduce_3

action_13 _ = happyReduce_23

action_14 _ = happyReduce_25

action_15 _ = happyReduce_24

action_16 (16) = happyShift action_29
action_16 _ = happyFail

action_17 (16) = happyShift action_27
action_17 (11) = happyGoto action_28
action_17 (12) = happyGoto action_26
action_17 _ = happyFail

action_18 (16) = happyShift action_27
action_18 (11) = happyGoto action_25
action_18 (12) = happyGoto action_26
action_18 _ = happyFail

action_19 (15) = happyShift action_14
action_19 (16) = happyShift action_15
action_19 (22) = happyShift action_16
action_19 (32) = happyShift action_17
action_19 (33) = happyShift action_18
action_19 (35) = happyShift action_19
action_19 (38) = happyShift action_20
action_19 (41) = happyShift action_21
action_19 (7) = happyGoto action_24
action_19 (8) = happyGoto action_13
action_19 _ = happyFail

action_20 (39) = happyShift action_23
action_20 _ = happyFail

action_21 (15) = happyShift action_14
action_21 (16) = happyShift action_15
action_21 (22) = happyShift action_16
action_21 (32) = happyShift action_17
action_21 (33) = happyShift action_18
action_21 (35) = happyShift action_19
action_21 (38) = happyShift action_20
action_21 (41) = happyShift action_21
action_21 (7) = happyGoto action_22
action_21 (8) = happyGoto action_13
action_21 _ = happyFail

action_22 (15) = happyShift action_14
action_22 (16) = happyShift action_15
action_22 (17) = happyShift action_31
action_22 (18) = happyShift action_32
action_22 (19) = happyShift action_33
action_22 (20) = happyShift action_34
action_22 (24) = happyShift action_35
action_22 (25) = happyShift action_36
action_22 (26) = happyShift action_37
action_22 (27) = happyShift action_38
action_22 (28) = happyShift action_39
action_22 (29) = happyShift action_40
action_22 (30) = happyShift action_41
action_22 (31) = happyShift action_42
action_22 (38) = happyShift action_20
action_22 (41) = happyShift action_21
action_22 (42) = happyShift action_62
action_22 (8) = happyGoto action_30
action_22 _ = happyFail

action_23 (15) = happyShift action_61
action_23 _ = happyFail

action_24 (15) = happyShift action_14
action_24 (16) = happyShift action_15
action_24 (17) = happyShift action_31
action_24 (18) = happyShift action_32
action_24 (19) = happyShift action_33
action_24 (20) = happyShift action_34
action_24 (24) = happyShift action_35
action_24 (25) = happyShift action_36
action_24 (26) = happyShift action_37
action_24 (27) = happyShift action_38
action_24 (28) = happyShift action_39
action_24 (29) = happyShift action_40
action_24 (30) = happyShift action_41
action_24 (31) = happyShift action_42
action_24 (36) = happyShift action_60
action_24 (38) = happyShift action_20
action_24 (41) = happyShift action_21
action_24 (8) = happyGoto action_30
action_24 _ = happyFail

action_25 (34) = happyShift action_59
action_25 _ = happyFail

action_26 (43) = happyShift action_58
action_26 _ = happyReduce_32

action_27 (21) = happyShift action_57
action_27 _ = happyFail

action_28 (34) = happyShift action_56
action_28 _ = happyFail

action_29 (16) = happyShift action_8
action_29 (6) = happyGoto action_55
action_29 _ = happyReduce_4

action_30 _ = happyReduce_6

action_31 (15) = happyShift action_14
action_31 (16) = happyShift action_15
action_31 (22) = happyShift action_16
action_31 (32) = happyShift action_17
action_31 (33) = happyShift action_18
action_31 (35) = happyShift action_19
action_31 (38) = happyShift action_20
action_31 (41) = happyShift action_21
action_31 (7) = happyGoto action_54
action_31 (8) = happyGoto action_13
action_31 _ = happyFail

action_32 (15) = happyShift action_14
action_32 (16) = happyShift action_15
action_32 (22) = happyShift action_16
action_32 (32) = happyShift action_17
action_32 (33) = happyShift action_18
action_32 (35) = happyShift action_19
action_32 (38) = happyShift action_20
action_32 (41) = happyShift action_21
action_32 (7) = happyGoto action_53
action_32 (8) = happyGoto action_13
action_32 _ = happyFail

action_33 (15) = happyShift action_14
action_33 (16) = happyShift action_15
action_33 (22) = happyShift action_16
action_33 (32) = happyShift action_17
action_33 (33) = happyShift action_18
action_33 (35) = happyShift action_19
action_33 (38) = happyShift action_20
action_33 (41) = happyShift action_21
action_33 (7) = happyGoto action_52
action_33 (8) = happyGoto action_13
action_33 _ = happyFail

action_34 (15) = happyShift action_14
action_34 (16) = happyShift action_15
action_34 (22) = happyShift action_16
action_34 (32) = happyShift action_17
action_34 (33) = happyShift action_18
action_34 (35) = happyShift action_19
action_34 (38) = happyShift action_20
action_34 (41) = happyShift action_21
action_34 (7) = happyGoto action_51
action_34 (8) = happyGoto action_13
action_34 _ = happyFail

action_35 (15) = happyShift action_14
action_35 (16) = happyShift action_15
action_35 (22) = happyShift action_16
action_35 (32) = happyShift action_17
action_35 (33) = happyShift action_18
action_35 (35) = happyShift action_19
action_35 (38) = happyShift action_20
action_35 (41) = happyShift action_21
action_35 (7) = happyGoto action_50
action_35 (8) = happyGoto action_13
action_35 _ = happyFail

action_36 (15) = happyShift action_14
action_36 (16) = happyShift action_15
action_36 (22) = happyShift action_16
action_36 (32) = happyShift action_17
action_36 (33) = happyShift action_18
action_36 (35) = happyShift action_19
action_36 (38) = happyShift action_20
action_36 (41) = happyShift action_21
action_36 (7) = happyGoto action_49
action_36 (8) = happyGoto action_13
action_36 _ = happyFail

action_37 (15) = happyShift action_14
action_37 (16) = happyShift action_15
action_37 (22) = happyShift action_16
action_37 (32) = happyShift action_17
action_37 (33) = happyShift action_18
action_37 (35) = happyShift action_19
action_37 (38) = happyShift action_20
action_37 (41) = happyShift action_21
action_37 (7) = happyGoto action_48
action_37 (8) = happyGoto action_13
action_37 _ = happyFail

action_38 (15) = happyShift action_14
action_38 (16) = happyShift action_15
action_38 (22) = happyShift action_16
action_38 (32) = happyShift action_17
action_38 (33) = happyShift action_18
action_38 (35) = happyShift action_19
action_38 (38) = happyShift action_20
action_38 (41) = happyShift action_21
action_38 (7) = happyGoto action_47
action_38 (8) = happyGoto action_13
action_38 _ = happyFail

action_39 (15) = happyShift action_14
action_39 (16) = happyShift action_15
action_39 (22) = happyShift action_16
action_39 (32) = happyShift action_17
action_39 (33) = happyShift action_18
action_39 (35) = happyShift action_19
action_39 (38) = happyShift action_20
action_39 (41) = happyShift action_21
action_39 (7) = happyGoto action_46
action_39 (8) = happyGoto action_13
action_39 _ = happyFail

action_40 (15) = happyShift action_14
action_40 (16) = happyShift action_15
action_40 (22) = happyShift action_16
action_40 (32) = happyShift action_17
action_40 (33) = happyShift action_18
action_40 (35) = happyShift action_19
action_40 (38) = happyShift action_20
action_40 (41) = happyShift action_21
action_40 (7) = happyGoto action_45
action_40 (8) = happyGoto action_13
action_40 _ = happyFail

action_41 (15) = happyShift action_14
action_41 (16) = happyShift action_15
action_41 (22) = happyShift action_16
action_41 (32) = happyShift action_17
action_41 (33) = happyShift action_18
action_41 (35) = happyShift action_19
action_41 (38) = happyShift action_20
action_41 (41) = happyShift action_21
action_41 (7) = happyGoto action_44
action_41 (8) = happyGoto action_13
action_41 _ = happyFail

action_42 (15) = happyShift action_14
action_42 (16) = happyShift action_15
action_42 (22) = happyShift action_16
action_42 (32) = happyShift action_17
action_42 (33) = happyShift action_18
action_42 (35) = happyShift action_19
action_42 (38) = happyShift action_20
action_42 (41) = happyShift action_21
action_42 (7) = happyGoto action_43
action_42 (8) = happyGoto action_13
action_42 _ = happyFail

action_43 (8) = happyGoto action_30
action_43 _ = happyReduce_12

action_44 (8) = happyGoto action_30
action_44 _ = happyReduce_11

action_45 (15) = happyFail
action_45 (16) = happyFail
action_45 (17) = happyShift action_31
action_45 (18) = happyShift action_32
action_45 (19) = happyShift action_33
action_45 (20) = happyShift action_34
action_45 (24) = happyFail
action_45 (25) = happyFail
action_45 (26) = happyFail
action_45 (27) = happyFail
action_45 (28) = happyFail
action_45 (29) = happyFail
action_45 (30) = happyShift action_41
action_45 (31) = happyShift action_42
action_45 (38) = happyFail
action_45 (41) = happyFail
action_45 (8) = happyGoto action_30
action_45 _ = happyReduce_18

action_46 (15) = happyFail
action_46 (16) = happyFail
action_46 (17) = happyShift action_31
action_46 (18) = happyShift action_32
action_46 (19) = happyShift action_33
action_46 (20) = happyShift action_34
action_46 (24) = happyFail
action_46 (25) = happyFail
action_46 (26) = happyFail
action_46 (27) = happyFail
action_46 (28) = happyFail
action_46 (29) = happyFail
action_46 (30) = happyShift action_41
action_46 (31) = happyShift action_42
action_46 (38) = happyFail
action_46 (41) = happyFail
action_46 (8) = happyGoto action_30
action_46 _ = happyReduce_17

action_47 (15) = happyFail
action_47 (16) = happyFail
action_47 (17) = happyShift action_31
action_47 (18) = happyShift action_32
action_47 (19) = happyShift action_33
action_47 (20) = happyShift action_34
action_47 (24) = happyFail
action_47 (25) = happyFail
action_47 (26) = happyFail
action_47 (27) = happyFail
action_47 (28) = happyFail
action_47 (29) = happyFail
action_47 (30) = happyShift action_41
action_47 (31) = happyShift action_42
action_47 (38) = happyFail
action_47 (41) = happyFail
action_47 (8) = happyGoto action_30
action_47 _ = happyReduce_16

action_48 (15) = happyFail
action_48 (16) = happyFail
action_48 (17) = happyShift action_31
action_48 (18) = happyShift action_32
action_48 (19) = happyShift action_33
action_48 (20) = happyShift action_34
action_48 (24) = happyFail
action_48 (25) = happyFail
action_48 (26) = happyFail
action_48 (27) = happyFail
action_48 (28) = happyFail
action_48 (29) = happyFail
action_48 (30) = happyShift action_41
action_48 (31) = happyShift action_42
action_48 (38) = happyFail
action_48 (41) = happyFail
action_48 (8) = happyGoto action_30
action_48 _ = happyReduce_15

action_49 (15) = happyFail
action_49 (16) = happyFail
action_49 (17) = happyShift action_31
action_49 (18) = happyShift action_32
action_49 (19) = happyShift action_33
action_49 (20) = happyShift action_34
action_49 (24) = happyFail
action_49 (25) = happyFail
action_49 (26) = happyFail
action_49 (27) = happyFail
action_49 (28) = happyFail
action_49 (29) = happyFail
action_49 (30) = happyShift action_41
action_49 (31) = happyShift action_42
action_49 (38) = happyFail
action_49 (41) = happyFail
action_49 (8) = happyGoto action_30
action_49 _ = happyReduce_14

action_50 (15) = happyFail
action_50 (16) = happyFail
action_50 (17) = happyShift action_31
action_50 (18) = happyShift action_32
action_50 (19) = happyShift action_33
action_50 (20) = happyShift action_34
action_50 (24) = happyFail
action_50 (25) = happyFail
action_50 (26) = happyFail
action_50 (27) = happyFail
action_50 (28) = happyFail
action_50 (29) = happyFail
action_50 (30) = happyShift action_41
action_50 (31) = happyShift action_42
action_50 (38) = happyFail
action_50 (41) = happyFail
action_50 (8) = happyGoto action_30
action_50 _ = happyReduce_13

action_51 (8) = happyGoto action_30
action_51 _ = happyReduce_10

action_52 (8) = happyGoto action_30
action_52 _ = happyReduce_9

action_53 (19) = happyShift action_33
action_53 (20) = happyShift action_34
action_53 (30) = happyShift action_41
action_53 (31) = happyShift action_42
action_53 (8) = happyGoto action_30
action_53 _ = happyReduce_8

action_54 (19) = happyShift action_33
action_54 (20) = happyShift action_34
action_54 (30) = happyShift action_41
action_54 (31) = happyShift action_42
action_54 (8) = happyGoto action_30
action_54 _ = happyReduce_7

action_55 (23) = happyShift action_71
action_55 _ = happyFail

action_56 (15) = happyShift action_14
action_56 (16) = happyShift action_15
action_56 (22) = happyShift action_16
action_56 (32) = happyShift action_17
action_56 (33) = happyShift action_18
action_56 (35) = happyShift action_19
action_56 (38) = happyShift action_20
action_56 (41) = happyShift action_21
action_56 (7) = happyGoto action_70
action_56 (8) = happyGoto action_13
action_56 _ = happyFail

action_57 (15) = happyShift action_14
action_57 (16) = happyShift action_15
action_57 (22) = happyShift action_16
action_57 (32) = happyShift action_17
action_57 (33) = happyShift action_18
action_57 (35) = happyShift action_19
action_57 (38) = happyShift action_20
action_57 (41) = happyShift action_21
action_57 (7) = happyGoto action_69
action_57 (8) = happyGoto action_13
action_57 _ = happyFail

action_58 (16) = happyShift action_27
action_58 (11) = happyGoto action_68
action_58 (12) = happyGoto action_26
action_58 _ = happyFail

action_59 (15) = happyShift action_14
action_59 (16) = happyShift action_15
action_59 (22) = happyShift action_16
action_59 (32) = happyShift action_17
action_59 (33) = happyShift action_18
action_59 (35) = happyShift action_19
action_59 (38) = happyShift action_20
action_59 (41) = happyShift action_21
action_59 (7) = happyGoto action_67
action_59 (8) = happyGoto action_13
action_59 _ = happyFail

action_60 (24) = happyShift action_66
action_60 (13) = happyGoto action_64
action_60 (14) = happyGoto action_65
action_60 _ = happyFail

action_61 (44) = happyShift action_63
action_61 _ = happyFail

action_62 _ = happyReduce_27

action_63 (15) = happyShift action_75
action_63 _ = happyFail

action_64 _ = happyReduce_21

action_65 (43) = happyShift action_74
action_65 _ = happyFail

action_66 (15) = happyShift action_73
action_66 _ = happyFail

action_67 (15) = happyShift action_14
action_67 (16) = happyShift action_15
action_67 (17) = happyShift action_31
action_67 (18) = happyShift action_32
action_67 (19) = happyShift action_33
action_67 (20) = happyShift action_34
action_67 (24) = happyShift action_35
action_67 (25) = happyShift action_36
action_67 (26) = happyShift action_37
action_67 (27) = happyShift action_38
action_67 (28) = happyShift action_39
action_67 (29) = happyShift action_40
action_67 (30) = happyShift action_41
action_67 (31) = happyShift action_42
action_67 (38) = happyShift action_20
action_67 (41) = happyShift action_21
action_67 (8) = happyGoto action_30
action_67 _ = happyReduce_20

action_68 _ = happyReduce_33

action_69 (15) = happyShift action_14
action_69 (16) = happyShift action_15
action_69 (17) = happyShift action_31
action_69 (18) = happyShift action_32
action_69 (19) = happyShift action_33
action_69 (20) = happyShift action_34
action_69 (24) = happyShift action_35
action_69 (25) = happyShift action_36
action_69 (26) = happyShift action_37
action_69 (27) = happyShift action_38
action_69 (28) = happyShift action_39
action_69 (29) = happyShift action_40
action_69 (30) = happyShift action_41
action_69 (31) = happyShift action_42
action_69 (38) = happyShift action_20
action_69 (41) = happyShift action_21
action_69 (8) = happyGoto action_30
action_69 _ = happyReduce_34

action_70 (15) = happyShift action_14
action_70 (16) = happyShift action_15
action_70 (17) = happyShift action_31
action_70 (18) = happyShift action_32
action_70 (19) = happyShift action_33
action_70 (20) = happyShift action_34
action_70 (24) = happyShift action_35
action_70 (25) = happyShift action_36
action_70 (26) = happyShift action_37
action_70 (27) = happyShift action_38
action_70 (28) = happyShift action_39
action_70 (29) = happyShift action_40
action_70 (30) = happyShift action_41
action_70 (31) = happyShift action_42
action_70 (38) = happyShift action_20
action_70 (41) = happyShift action_21
action_70 (8) = happyGoto action_30
action_70 _ = happyReduce_19

action_71 (15) = happyShift action_14
action_71 (16) = happyShift action_15
action_71 (22) = happyShift action_16
action_71 (32) = happyShift action_17
action_71 (33) = happyShift action_18
action_71 (35) = happyShift action_19
action_71 (38) = happyShift action_20
action_71 (41) = happyShift action_21
action_71 (7) = happyGoto action_72
action_71 (8) = happyGoto action_13
action_71 _ = happyFail

action_72 (15) = happyFail
action_72 (16) = happyFail
action_72 (17) = happyShift action_31
action_72 (18) = happyShift action_32
action_72 (19) = happyShift action_33
action_72 (20) = happyShift action_34
action_72 (24) = happyFail
action_72 (25) = happyFail
action_72 (26) = happyFail
action_72 (27) = happyFail
action_72 (28) = happyFail
action_72 (29) = happyFail
action_72 (30) = happyShift action_41
action_72 (31) = happyShift action_42
action_72 (38) = happyFail
action_72 (41) = happyFail
action_72 (8) = happyGoto action_30
action_72 _ = happyReduce_22

action_73 (29) = happyShift action_78
action_73 _ = happyFail

action_74 (24) = happyShift action_66
action_74 (13) = happyGoto action_77
action_74 (14) = happyGoto action_65
action_74 _ = happyReduce_35

action_75 (40) = happyShift action_76
action_75 _ = happyFail

action_76 (41) = happyShift action_80
action_76 _ = happyFail

action_77 _ = happyReduce_36

action_78 (16) = happyShift action_8
action_78 (6) = happyGoto action_79
action_78 _ = happyReduce_4

action_79 (37) = happyShift action_84
action_79 _ = happyFail

action_80 (15) = happyShift action_14
action_80 (16) = happyShift action_15
action_80 (22) = happyShift action_16
action_80 (32) = happyShift action_17
action_80 (33) = happyShift action_18
action_80 (35) = happyShift action_19
action_80 (38) = happyShift action_20
action_80 (41) = happyShift action_21
action_80 (7) = happyGoto action_81
action_80 (8) = happyGoto action_13
action_80 (9) = happyGoto action_82
action_80 (10) = happyGoto action_83
action_80 _ = happyReduce_28

action_81 (15) = happyShift action_14
action_81 (16) = happyShift action_15
action_81 (17) = happyShift action_31
action_81 (18) = happyShift action_32
action_81 (19) = happyShift action_33
action_81 (20) = happyShift action_34
action_81 (24) = happyShift action_35
action_81 (25) = happyShift action_36
action_81 (26) = happyShift action_37
action_81 (27) = happyShift action_38
action_81 (28) = happyShift action_39
action_81 (29) = happyShift action_40
action_81 (30) = happyShift action_41
action_81 (31) = happyShift action_42
action_81 (38) = happyShift action_20
action_81 (41) = happyShift action_21
action_81 (44) = happyShift action_87
action_81 (8) = happyGoto action_30
action_81 _ = happyReduce_30

action_82 (42) = happyShift action_86
action_82 _ = happyFail

action_83 _ = happyReduce_29

action_84 (15) = happyShift action_14
action_84 (16) = happyShift action_15
action_84 (22) = happyShift action_16
action_84 (32) = happyShift action_17
action_84 (33) = happyShift action_18
action_84 (35) = happyShift action_19
action_84 (38) = happyShift action_20
action_84 (41) = happyShift action_21
action_84 (7) = happyGoto action_85
action_84 (8) = happyGoto action_13
action_84 _ = happyFail

action_85 (15) = happyShift action_14
action_85 (16) = happyShift action_15
action_85 (17) = happyShift action_31
action_85 (18) = happyShift action_32
action_85 (19) = happyShift action_33
action_85 (20) = happyShift action_34
action_85 (24) = happyShift action_35
action_85 (25) = happyShift action_36
action_85 (26) = happyShift action_37
action_85 (27) = happyShift action_38
action_85 (28) = happyShift action_39
action_85 (29) = happyShift action_40
action_85 (30) = happyShift action_41
action_85 (31) = happyShift action_42
action_85 (38) = happyShift action_20
action_85 (41) = happyShift action_21
action_85 (8) = happyGoto action_30
action_85 _ = happyReduce_37

action_86 _ = happyReduce_26

action_87 (15) = happyShift action_14
action_87 (16) = happyShift action_15
action_87 (22) = happyShift action_16
action_87 (32) = happyShift action_17
action_87 (33) = happyShift action_18
action_87 (35) = happyShift action_19
action_87 (38) = happyShift action_20
action_87 (41) = happyShift action_21
action_87 (7) = happyGoto action_81
action_87 (8) = happyGoto action_13
action_87 (10) = happyGoto action_88
action_87 _ = happyFail

action_88 _ = happyReduce_31

happyReduce_1 = happySpecReduce_1  4 happyReduction_1
happyReduction_1 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 ([happy_var_1]
	)
happyReduction_1 _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_3  4 happyReduction_2
happyReduction_2 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1 : happy_var_3
	)
happyReduction_2 _ _ _  = notHappyAtAll 

happyReduce_3 = happyReduce 4 5 happyReduction_3
happyReduction_3 ((HappyAbsSyn7  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_2) `HappyStk`
	(HappyTerminal (TokenSym happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 ((happy_var_1, happy_var_2, happy_var_4)
	) `HappyStk` happyRest

happyReduce_4 = happySpecReduce_0  6 happyReduction_4
happyReduction_4  =  HappyAbsSyn6
		 ([]
	)

happyReduce_5 = happySpecReduce_2  6 happyReduction_5
happyReduction_5 (HappyAbsSyn6  happy_var_2)
	(HappyTerminal (TokenSym happy_var_1))
	 =  HappyAbsSyn6
		 (happy_var_1 : happy_var_2
	)
happyReduction_5 _ _  = notHappyAtAll 

happyReduce_6 = happySpecReduce_2  7 happyReduction_6
happyReduction_6 (HappyAbsSyn8  happy_var_2)
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (EAp happy_var_1 happy_var_2
	)
happyReduction_6 _ _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_3  7 happyReduction_7
happyReduction_7 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (EAp (EAp (EVar "+") happy_var_1) happy_var_3
	)
happyReduction_7 _ _ _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_3  7 happyReduction_8
happyReduction_8 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (EAp (EAp (EVar "-") happy_var_1) happy_var_3
	)
happyReduction_8 _ _ _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_3  7 happyReduction_9
happyReduction_9 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (EAp (EAp (EVar "*") happy_var_1) happy_var_3
	)
happyReduction_9 _ _ _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_3  7 happyReduction_10
happyReduction_10 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (EAp (EAp (EVar "/") happy_var_1) happy_var_3
	)
happyReduction_10 _ _ _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_3  7 happyReduction_11
happyReduction_11 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (EAp (EAp (EVar "and") happy_var_1) happy_var_3
	)
happyReduction_11 _ _ _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_3  7 happyReduction_12
happyReduction_12 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (EAp (EAp (EVar "or") happy_var_1) happy_var_3
	)
happyReduction_12 _ _ _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_3  7 happyReduction_13
happyReduction_13 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (EAp (EAp (EVar "<") happy_var_1) happy_var_3
	)
happyReduction_13 _ _ _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_3  7 happyReduction_14
happyReduction_14 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (EAp (EAp (EVar "<=") happy_var_1) happy_var_3
	)
happyReduction_14 _ _ _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_3  7 happyReduction_15
happyReduction_15 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (EAp (EAp (EVar "==") happy_var_1) happy_var_3
	)
happyReduction_15 _ _ _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_3  7 happyReduction_16
happyReduction_16 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (EAp (EAp (EVar "/=") happy_var_1) happy_var_3
	)
happyReduction_16 _ _ _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_3  7 happyReduction_17
happyReduction_17 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (EAp (EAp (EVar ">=") happy_var_1) happy_var_3
	)
happyReduction_17 _ _ _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_3  7 happyReduction_18
happyReduction_18 (HappyAbsSyn7  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn7
		 (EAp (EAp (EVar ">") happy_var_1) happy_var_3
	)
happyReduction_18 _ _ _  = notHappyAtAll 

happyReduce_19 = happyReduce 4 7 happyReduction_19
happyReduction_19 ((HappyAbsSyn7  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn11  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (ELet nonRecursive happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_20 = happyReduce 4 7 happyReduction_20
happyReduction_20 ((HappyAbsSyn7  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn11  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (ELet recursive happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_21 = happyReduce 4 7 happyReduction_21
happyReduction_21 ((HappyAbsSyn13  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn7  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (ECase happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_22 = happyReduce 5 7 happyReduction_22
happyReduction_22 ((HappyAbsSyn7  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_3) `HappyStk`
	(HappyTerminal (TokenSym happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (ELam (happy_var_2 : happy_var_3) happy_var_5
	) `HappyStk` happyRest

happyReduce_23 = happySpecReduce_1  7 happyReduction_23
happyReduction_23 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_23 _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_1  8 happyReduction_24
happyReduction_24 (HappyTerminal (TokenSym happy_var_1))
	 =  HappyAbsSyn8
		 (EVar happy_var_1
	)
happyReduction_24 _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_1  8 happyReduction_25
happyReduction_25 (HappyTerminal (TokenInt happy_var_1))
	 =  HappyAbsSyn8
		 (ENum happy_var_1
	)
happyReduction_25 _  = notHappyAtAll 

happyReduce_26 = happyReduce 9 8 happyReduction_26
happyReduction_26 (_ `HappyStk`
	(HappyAbsSyn9  happy_var_8) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenInt happy_var_5)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenInt happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn8
		 (EConstr happy_var_3 happy_var_5 happy_var_8
	) `HappyStk` happyRest

happyReduce_27 = happySpecReduce_3  8 happyReduction_27
happyReduction_27 _
	(HappyAbsSyn7  happy_var_2)
	_
	 =  HappyAbsSyn8
		 (happy_var_2
	)
happyReduction_27 _ _ _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_0  9 happyReduction_28
happyReduction_28  =  HappyAbsSyn9
		 ([]
	)

happyReduce_29 = happySpecReduce_1  9 happyReduction_29
happyReduction_29 (HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn9
		 (happy_var_1
	)
happyReduction_29 _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_1  10 happyReduction_30
happyReduction_30 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn10
		 ([happy_var_1]
	)
happyReduction_30 _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_3  10 happyReduction_31
happyReduction_31 (HappyAbsSyn10  happy_var_3)
	_
	(HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn10
		 (happy_var_1 : happy_var_3
	)
happyReduction_31 _ _ _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_1  11 happyReduction_32
happyReduction_32 (HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn11
		 ([happy_var_1]
	)
happyReduction_32 _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_3  11 happyReduction_33
happyReduction_33 (HappyAbsSyn11  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn11
		 (happy_var_1 : happy_var_3
	)
happyReduction_33 _ _ _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_3  12 happyReduction_34
happyReduction_34 (HappyAbsSyn7  happy_var_3)
	_
	(HappyTerminal (TokenSym happy_var_1))
	 =  HappyAbsSyn12
		 ((happy_var_1, happy_var_3)
	)
happyReduction_34 _ _ _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_2  13 happyReduction_35
happyReduction_35 _
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn13
		 ([happy_var_1]
	)
happyReduction_35 _ _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_3  13 happyReduction_36
happyReduction_36 (HappyAbsSyn13  happy_var_3)
	_
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn13
		 (happy_var_1 : happy_var_3
	)
happyReduction_36 _ _ _  = notHappyAtAll 

happyReduce_37 = happyReduce 6 14 happyReduction_37
happyReduction_37 ((HappyAbsSyn7  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn6  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenInt happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn14
		 ((happy_var_2, happy_var_4, happy_var_6)
	) `HappyStk` happyRest

happyNewToken action sts stk [] =
	action 45 45 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TokenInt happy_dollar_dollar -> cont 15;
	TokenSym happy_dollar_dollar -> cont 16;
	TokenAdd -> cont 17;
	TokenMin -> cont 18;
	TokenMul -> cont 19;
	TokenDiv -> cont 20;
	TokenAssign -> cont 21;
	TokenLamVars -> cont 22;
	TokenLamExpr -> cont 23;
	TokenLT -> cont 24;
	TokenLTE -> cont 25;
	TokenEQ -> cont 26;
	TokenNEQ -> cont 27;
	TokenGTE -> cont 28;
	TokenGT -> cont 29;
	TokenAnd -> cont 30;
	TokenOr -> cont 31;
	TokenLet -> cont 32;
	TokenLetRec -> cont 33;
	TokenIn -> cont 34;
	TokenCase -> cont 35;
	TokenOf -> cont 36;
	TokenArrow -> cont 37;
	TokenPack -> cont 38;
	TokenLBrace -> cont 39;
	TokenRBrace -> cont 40;
	TokenLParen -> cont 41;
	TokenRParen -> cont 42;
	TokenSemiColon -> cont 43;
	TokenComma -> cont 44;
	_ -> happyError' (tk:tks)
	}

happyError_ 45 tk tks = happyError' tks
happyError_ _ tk tks = happyError' (tk:tks)

newtype HappyIdentity a = HappyIdentity a
happyIdentity = HappyIdentity
happyRunIdentity (HappyIdentity a) = a

instance Functor HappyIdentity where
    fmap f (HappyIdentity a) = HappyIdentity (f a)

instance Applicative HappyIdentity where
    pure  = return
    (<*>) = ap
instance Monad HappyIdentity where
    return = HappyIdentity
    (HappyIdentity p) >>= q = q p

happyThen :: () => HappyIdentity a -> (a -> HappyIdentity b) -> HappyIdentity b
happyThen = (>>=)
happyReturn :: () => a -> HappyIdentity a
happyReturn = (return)
happyThen1 m k tks = (>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> HappyIdentity a
happyReturn1 = \a tks -> (return) a
happyError' :: () => [(Token)] -> HappyIdentity a
happyError' = HappyIdentity . parseError

parseTokens tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


parseError :: [Token] -> a
parseError _ = error "Parse error"
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "<built-in>" #-}
{-# LINE 16 "<built-in>" #-}
{-# LINE 1 "/Users/davidanekstein/.stack/programs/x86_64-osx/ghc-7.10.3/lib/ghc-7.10.3/include/ghcversion.h" #-}


















{-# LINE 17 "<built-in>" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 


{-# LINE 13 "templates/GenericTemplate.hs" #-}


{-# LINE 46 "templates/GenericTemplate.hs" #-}









{-# LINE 67 "templates/GenericTemplate.hs" #-}


{-# LINE 77 "templates/GenericTemplate.hs" #-}










infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is (1), it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action


{-# LINE 155 "templates/GenericTemplate.hs" #-}

-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction









happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery ((1) is the error token)

-- parse error if we are in recovery and we fail again
happyFail (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  (1) tk old_st (((HappyState (action))):(sts)) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        action (1) (1) tk (HappyState (action)) sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail  i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ( (HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.









{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.

