{-# OPTIONS_GHC -w #-}
module Parser where
import Lexer
import Types
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.5

data HappyAbsSyn t4 t5 t6 t7 t8 t9 t10 t11 t12
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

action_0 (14) = happyShift action_3
action_0 (4) = happyGoto action_4
action_0 (5) = happyGoto action_5
action_0 _ = happyFail

action_1 (14) = happyShift action_3
action_1 (5) = happyGoto action_2
action_1 _ = happyFail

action_2 _ = happyFail

action_3 (14) = happyShift action_7
action_3 _ = happyFail

action_4 (43) = happyAccept
action_4 _ = happyFail

action_5 (41) = happyShift action_6
action_5 _ = happyReduce_1

action_6 (14) = happyShift action_3
action_6 (4) = happyGoto action_10
action_6 (5) = happyGoto action_5
action_6 _ = happyFail

action_7 (14) = happyShift action_9
action_7 (6) = happyGoto action_8
action_7 _ = happyReduce_4

action_8 (19) = happyShift action_12
action_8 _ = happyFail

action_9 (14) = happyShift action_9
action_9 (6) = happyGoto action_11
action_9 _ = happyReduce_4

action_10 _ = happyReduce_2

action_11 _ = happyReduce_5

action_12 (13) = happyShift action_15
action_12 (14) = happyShift action_16
action_12 (20) = happyShift action_17
action_12 (30) = happyShift action_18
action_12 (31) = happyShift action_19
action_12 (33) = happyShift action_20
action_12 (36) = happyShift action_21
action_12 (39) = happyShift action_22
action_12 (7) = happyGoto action_13
action_12 (8) = happyGoto action_14
action_12 _ = happyFail

action_13 (13) = happyShift action_15
action_13 (14) = happyShift action_16
action_13 (15) = happyShift action_32
action_13 (16) = happyShift action_33
action_13 (17) = happyShift action_34
action_13 (18) = happyShift action_35
action_13 (22) = happyShift action_36
action_13 (23) = happyShift action_37
action_13 (24) = happyShift action_38
action_13 (25) = happyShift action_39
action_13 (26) = happyShift action_40
action_13 (27) = happyShift action_41
action_13 (28) = happyShift action_42
action_13 (29) = happyShift action_43
action_13 (36) = happyShift action_21
action_13 (39) = happyShift action_22
action_13 (8) = happyGoto action_31
action_13 _ = happyReduce_3

action_14 _ = happyReduce_23

action_15 _ = happyReduce_25

action_16 _ = happyReduce_24

action_17 (14) = happyShift action_30
action_17 _ = happyFail

action_18 (14) = happyShift action_28
action_18 (9) = happyGoto action_29
action_18 (10) = happyGoto action_27
action_18 _ = happyFail

action_19 (14) = happyShift action_28
action_19 (9) = happyGoto action_26
action_19 (10) = happyGoto action_27
action_19 _ = happyFail

action_20 (13) = happyShift action_15
action_20 (14) = happyShift action_16
action_20 (20) = happyShift action_17
action_20 (30) = happyShift action_18
action_20 (31) = happyShift action_19
action_20 (33) = happyShift action_20
action_20 (36) = happyShift action_21
action_20 (39) = happyShift action_22
action_20 (7) = happyGoto action_25
action_20 (8) = happyGoto action_14
action_20 _ = happyFail

action_21 (37) = happyShift action_24
action_21 _ = happyFail

action_22 (13) = happyShift action_15
action_22 (14) = happyShift action_16
action_22 (20) = happyShift action_17
action_22 (30) = happyShift action_18
action_22 (31) = happyShift action_19
action_22 (33) = happyShift action_20
action_22 (36) = happyShift action_21
action_22 (39) = happyShift action_22
action_22 (7) = happyGoto action_23
action_22 (8) = happyGoto action_14
action_22 _ = happyFail

action_23 (13) = happyShift action_15
action_23 (14) = happyShift action_16
action_23 (15) = happyShift action_32
action_23 (16) = happyShift action_33
action_23 (17) = happyShift action_34
action_23 (18) = happyShift action_35
action_23 (22) = happyShift action_36
action_23 (23) = happyShift action_37
action_23 (24) = happyShift action_38
action_23 (25) = happyShift action_39
action_23 (26) = happyShift action_40
action_23 (27) = happyShift action_41
action_23 (28) = happyShift action_42
action_23 (29) = happyShift action_43
action_23 (36) = happyShift action_21
action_23 (39) = happyShift action_22
action_23 (40) = happyShift action_63
action_23 (8) = happyGoto action_31
action_23 _ = happyFail

action_24 (13) = happyShift action_62
action_24 _ = happyFail

action_25 (13) = happyShift action_15
action_25 (14) = happyShift action_16
action_25 (15) = happyShift action_32
action_25 (16) = happyShift action_33
action_25 (17) = happyShift action_34
action_25 (18) = happyShift action_35
action_25 (22) = happyShift action_36
action_25 (23) = happyShift action_37
action_25 (24) = happyShift action_38
action_25 (25) = happyShift action_39
action_25 (26) = happyShift action_40
action_25 (27) = happyShift action_41
action_25 (28) = happyShift action_42
action_25 (29) = happyShift action_43
action_25 (34) = happyShift action_61
action_25 (36) = happyShift action_21
action_25 (39) = happyShift action_22
action_25 (8) = happyGoto action_31
action_25 _ = happyFail

action_26 (32) = happyShift action_60
action_26 _ = happyFail

action_27 (41) = happyShift action_59
action_27 _ = happyReduce_28

action_28 (19) = happyShift action_58
action_28 _ = happyFail

action_29 (32) = happyShift action_57
action_29 _ = happyFail

action_30 (14) = happyShift action_9
action_30 (6) = happyGoto action_56
action_30 _ = happyReduce_4

action_31 _ = happyReduce_6

action_32 (13) = happyShift action_15
action_32 (14) = happyShift action_16
action_32 (20) = happyShift action_17
action_32 (30) = happyShift action_18
action_32 (31) = happyShift action_19
action_32 (33) = happyShift action_20
action_32 (36) = happyShift action_21
action_32 (39) = happyShift action_22
action_32 (7) = happyGoto action_55
action_32 (8) = happyGoto action_14
action_32 _ = happyFail

action_33 (13) = happyShift action_15
action_33 (14) = happyShift action_16
action_33 (20) = happyShift action_17
action_33 (30) = happyShift action_18
action_33 (31) = happyShift action_19
action_33 (33) = happyShift action_20
action_33 (36) = happyShift action_21
action_33 (39) = happyShift action_22
action_33 (7) = happyGoto action_54
action_33 (8) = happyGoto action_14
action_33 _ = happyFail

action_34 (13) = happyShift action_15
action_34 (14) = happyShift action_16
action_34 (20) = happyShift action_17
action_34 (30) = happyShift action_18
action_34 (31) = happyShift action_19
action_34 (33) = happyShift action_20
action_34 (36) = happyShift action_21
action_34 (39) = happyShift action_22
action_34 (7) = happyGoto action_53
action_34 (8) = happyGoto action_14
action_34 _ = happyFail

action_35 (13) = happyShift action_15
action_35 (14) = happyShift action_16
action_35 (20) = happyShift action_17
action_35 (30) = happyShift action_18
action_35 (31) = happyShift action_19
action_35 (33) = happyShift action_20
action_35 (36) = happyShift action_21
action_35 (39) = happyShift action_22
action_35 (7) = happyGoto action_52
action_35 (8) = happyGoto action_14
action_35 _ = happyFail

action_36 (13) = happyShift action_15
action_36 (14) = happyShift action_16
action_36 (20) = happyShift action_17
action_36 (30) = happyShift action_18
action_36 (31) = happyShift action_19
action_36 (33) = happyShift action_20
action_36 (36) = happyShift action_21
action_36 (39) = happyShift action_22
action_36 (7) = happyGoto action_51
action_36 (8) = happyGoto action_14
action_36 _ = happyFail

action_37 (13) = happyShift action_15
action_37 (14) = happyShift action_16
action_37 (20) = happyShift action_17
action_37 (30) = happyShift action_18
action_37 (31) = happyShift action_19
action_37 (33) = happyShift action_20
action_37 (36) = happyShift action_21
action_37 (39) = happyShift action_22
action_37 (7) = happyGoto action_50
action_37 (8) = happyGoto action_14
action_37 _ = happyFail

action_38 (13) = happyShift action_15
action_38 (14) = happyShift action_16
action_38 (20) = happyShift action_17
action_38 (30) = happyShift action_18
action_38 (31) = happyShift action_19
action_38 (33) = happyShift action_20
action_38 (36) = happyShift action_21
action_38 (39) = happyShift action_22
action_38 (7) = happyGoto action_49
action_38 (8) = happyGoto action_14
action_38 _ = happyFail

action_39 (13) = happyShift action_15
action_39 (14) = happyShift action_16
action_39 (20) = happyShift action_17
action_39 (30) = happyShift action_18
action_39 (31) = happyShift action_19
action_39 (33) = happyShift action_20
action_39 (36) = happyShift action_21
action_39 (39) = happyShift action_22
action_39 (7) = happyGoto action_48
action_39 (8) = happyGoto action_14
action_39 _ = happyFail

action_40 (13) = happyShift action_15
action_40 (14) = happyShift action_16
action_40 (20) = happyShift action_17
action_40 (30) = happyShift action_18
action_40 (31) = happyShift action_19
action_40 (33) = happyShift action_20
action_40 (36) = happyShift action_21
action_40 (39) = happyShift action_22
action_40 (7) = happyGoto action_47
action_40 (8) = happyGoto action_14
action_40 _ = happyFail

action_41 (13) = happyShift action_15
action_41 (14) = happyShift action_16
action_41 (20) = happyShift action_17
action_41 (30) = happyShift action_18
action_41 (31) = happyShift action_19
action_41 (33) = happyShift action_20
action_41 (36) = happyShift action_21
action_41 (39) = happyShift action_22
action_41 (7) = happyGoto action_46
action_41 (8) = happyGoto action_14
action_41 _ = happyFail

action_42 (13) = happyShift action_15
action_42 (14) = happyShift action_16
action_42 (20) = happyShift action_17
action_42 (30) = happyShift action_18
action_42 (31) = happyShift action_19
action_42 (33) = happyShift action_20
action_42 (36) = happyShift action_21
action_42 (39) = happyShift action_22
action_42 (7) = happyGoto action_45
action_42 (8) = happyGoto action_14
action_42 _ = happyFail

action_43 (13) = happyShift action_15
action_43 (14) = happyShift action_16
action_43 (20) = happyShift action_17
action_43 (30) = happyShift action_18
action_43 (31) = happyShift action_19
action_43 (33) = happyShift action_20
action_43 (36) = happyShift action_21
action_43 (39) = happyShift action_22
action_43 (7) = happyGoto action_44
action_43 (8) = happyGoto action_14
action_43 _ = happyFail

action_44 (13) = happyFail
action_44 (14) = happyFail
action_44 (15) = happyShift action_32
action_44 (16) = happyShift action_33
action_44 (17) = happyShift action_34
action_44 (18) = happyFail
action_44 (22) = happyFail
action_44 (23) = happyFail
action_44 (24) = happyFail
action_44 (25) = happyFail
action_44 (26) = happyFail
action_44 (27) = happyFail
action_44 (28) = happyFail
action_44 (29) = happyFail
action_44 (36) = happyFail
action_44 (39) = happyFail
action_44 (8) = happyGoto action_31
action_44 _ = happyReduce_12

action_45 (13) = happyFail
action_45 (14) = happyFail
action_45 (15) = happyShift action_32
action_45 (16) = happyShift action_33
action_45 (17) = happyShift action_34
action_45 (18) = happyFail
action_45 (22) = happyFail
action_45 (23) = happyFail
action_45 (24) = happyFail
action_45 (25) = happyFail
action_45 (26) = happyFail
action_45 (27) = happyFail
action_45 (28) = happyFail
action_45 (29) = happyFail
action_45 (36) = happyFail
action_45 (39) = happyFail
action_45 (8) = happyGoto action_31
action_45 _ = happyReduce_11

action_46 (13) = happyFail
action_46 (14) = happyFail
action_46 (15) = happyShift action_32
action_46 (16) = happyShift action_33
action_46 (17) = happyShift action_34
action_46 (18) = happyFail
action_46 (22) = happyFail
action_46 (23) = happyFail
action_46 (24) = happyFail
action_46 (25) = happyFail
action_46 (26) = happyFail
action_46 (27) = happyFail
action_46 (28) = happyFail
action_46 (29) = happyFail
action_46 (36) = happyFail
action_46 (39) = happyFail
action_46 (8) = happyGoto action_31
action_46 _ = happyReduce_18

action_47 (13) = happyFail
action_47 (14) = happyFail
action_47 (15) = happyShift action_32
action_47 (16) = happyShift action_33
action_47 (17) = happyShift action_34
action_47 (18) = happyFail
action_47 (22) = happyFail
action_47 (23) = happyFail
action_47 (24) = happyFail
action_47 (25) = happyFail
action_47 (26) = happyFail
action_47 (27) = happyFail
action_47 (28) = happyFail
action_47 (29) = happyFail
action_47 (36) = happyFail
action_47 (39) = happyFail
action_47 (8) = happyGoto action_31
action_47 _ = happyReduce_17

action_48 (13) = happyFail
action_48 (14) = happyFail
action_48 (15) = happyShift action_32
action_48 (16) = happyShift action_33
action_48 (17) = happyShift action_34
action_48 (18) = happyFail
action_48 (22) = happyFail
action_48 (23) = happyFail
action_48 (24) = happyFail
action_48 (25) = happyFail
action_48 (26) = happyFail
action_48 (27) = happyFail
action_48 (28) = happyFail
action_48 (29) = happyFail
action_48 (36) = happyFail
action_48 (39) = happyFail
action_48 (8) = happyGoto action_31
action_48 _ = happyReduce_16

action_49 (13) = happyFail
action_49 (14) = happyFail
action_49 (15) = happyShift action_32
action_49 (16) = happyShift action_33
action_49 (17) = happyShift action_34
action_49 (18) = happyFail
action_49 (22) = happyFail
action_49 (23) = happyFail
action_49 (24) = happyFail
action_49 (25) = happyFail
action_49 (26) = happyFail
action_49 (27) = happyFail
action_49 (28) = happyFail
action_49 (29) = happyFail
action_49 (36) = happyFail
action_49 (39) = happyFail
action_49 (8) = happyGoto action_31
action_49 _ = happyReduce_15

action_50 (13) = happyFail
action_50 (14) = happyFail
action_50 (15) = happyShift action_32
action_50 (16) = happyShift action_33
action_50 (17) = happyShift action_34
action_50 (18) = happyFail
action_50 (22) = happyFail
action_50 (23) = happyFail
action_50 (24) = happyFail
action_50 (25) = happyFail
action_50 (26) = happyFail
action_50 (27) = happyFail
action_50 (28) = happyFail
action_50 (29) = happyFail
action_50 (36) = happyFail
action_50 (39) = happyFail
action_50 (8) = happyGoto action_31
action_50 _ = happyReduce_14

action_51 (13) = happyFail
action_51 (14) = happyFail
action_51 (15) = happyShift action_32
action_51 (16) = happyShift action_33
action_51 (17) = happyShift action_34
action_51 (18) = happyFail
action_51 (22) = happyFail
action_51 (23) = happyFail
action_51 (24) = happyFail
action_51 (25) = happyFail
action_51 (26) = happyFail
action_51 (27) = happyFail
action_51 (28) = happyFail
action_51 (29) = happyFail
action_51 (36) = happyFail
action_51 (39) = happyFail
action_51 (8) = happyGoto action_31
action_51 _ = happyReduce_13

action_52 (13) = happyFail
action_52 (14) = happyFail
action_52 (15) = happyShift action_32
action_52 (16) = happyShift action_33
action_52 (17) = happyShift action_34
action_52 (18) = happyFail
action_52 (22) = happyFail
action_52 (23) = happyFail
action_52 (24) = happyFail
action_52 (25) = happyFail
action_52 (26) = happyFail
action_52 (27) = happyFail
action_52 (28) = happyFail
action_52 (29) = happyFail
action_52 (36) = happyFail
action_52 (39) = happyFail
action_52 (8) = happyGoto action_31
action_52 _ = happyReduce_10

action_53 (8) = happyGoto action_31
action_53 _ = happyReduce_9

action_54 (17) = happyShift action_34
action_54 (8) = happyGoto action_31
action_54 _ = happyReduce_8

action_55 (17) = happyShift action_34
action_55 (8) = happyGoto action_31
action_55 _ = happyReduce_7

action_56 (21) = happyShift action_72
action_56 _ = happyFail

action_57 (13) = happyShift action_15
action_57 (14) = happyShift action_16
action_57 (20) = happyShift action_17
action_57 (30) = happyShift action_18
action_57 (31) = happyShift action_19
action_57 (33) = happyShift action_20
action_57 (36) = happyShift action_21
action_57 (39) = happyShift action_22
action_57 (7) = happyGoto action_71
action_57 (8) = happyGoto action_14
action_57 _ = happyFail

action_58 (13) = happyShift action_15
action_58 (14) = happyShift action_16
action_58 (20) = happyShift action_17
action_58 (30) = happyShift action_18
action_58 (31) = happyShift action_19
action_58 (33) = happyShift action_20
action_58 (36) = happyShift action_21
action_58 (39) = happyShift action_22
action_58 (7) = happyGoto action_70
action_58 (8) = happyGoto action_14
action_58 _ = happyFail

action_59 (14) = happyShift action_28
action_59 (9) = happyGoto action_69
action_59 (10) = happyGoto action_27
action_59 _ = happyFail

action_60 (13) = happyShift action_15
action_60 (14) = happyShift action_16
action_60 (20) = happyShift action_17
action_60 (30) = happyShift action_18
action_60 (31) = happyShift action_19
action_60 (33) = happyShift action_20
action_60 (36) = happyShift action_21
action_60 (39) = happyShift action_22
action_60 (7) = happyGoto action_68
action_60 (8) = happyGoto action_14
action_60 _ = happyFail

action_61 (22) = happyShift action_67
action_61 (11) = happyGoto action_65
action_61 (12) = happyGoto action_66
action_61 _ = happyFail

action_62 (42) = happyShift action_64
action_62 _ = happyFail

action_63 _ = happyReduce_27

action_64 (13) = happyShift action_77
action_64 _ = happyFail

action_65 _ = happyReduce_21

action_66 (22) = happyShift action_67
action_66 (41) = happyShift action_76
action_66 (11) = happyGoto action_75
action_66 (12) = happyGoto action_66
action_66 _ = happyFail

action_67 (13) = happyShift action_74
action_67 _ = happyFail

action_68 (13) = happyFail
action_68 (14) = happyFail
action_68 (15) = happyShift action_32
action_68 (16) = happyShift action_33
action_68 (17) = happyShift action_34
action_68 (18) = happyFail
action_68 (22) = happyFail
action_68 (23) = happyFail
action_68 (24) = happyFail
action_68 (25) = happyFail
action_68 (26) = happyFail
action_68 (27) = happyFail
action_68 (28) = happyFail
action_68 (29) = happyFail
action_68 (36) = happyFail
action_68 (39) = happyFail
action_68 (8) = happyGoto action_31
action_68 _ = happyReduce_20

action_69 _ = happyReduce_29

action_70 (13) = happyShift action_15
action_70 (14) = happyShift action_16
action_70 (15) = happyShift action_32
action_70 (16) = happyShift action_33
action_70 (17) = happyShift action_34
action_70 (18) = happyShift action_35
action_70 (22) = happyShift action_36
action_70 (23) = happyShift action_37
action_70 (24) = happyShift action_38
action_70 (25) = happyShift action_39
action_70 (26) = happyShift action_40
action_70 (27) = happyShift action_41
action_70 (28) = happyShift action_42
action_70 (29) = happyShift action_43
action_70 (36) = happyShift action_21
action_70 (39) = happyShift action_22
action_70 (8) = happyGoto action_31
action_70 _ = happyReduce_30

action_71 (13) = happyFail
action_71 (14) = happyFail
action_71 (15) = happyShift action_32
action_71 (16) = happyShift action_33
action_71 (17) = happyShift action_34
action_71 (18) = happyFail
action_71 (22) = happyFail
action_71 (23) = happyFail
action_71 (24) = happyFail
action_71 (25) = happyFail
action_71 (26) = happyFail
action_71 (27) = happyFail
action_71 (28) = happyFail
action_71 (29) = happyFail
action_71 (36) = happyFail
action_71 (39) = happyFail
action_71 (8) = happyGoto action_31
action_71 _ = happyReduce_19

action_72 (13) = happyShift action_15
action_72 (14) = happyShift action_16
action_72 (20) = happyShift action_17
action_72 (30) = happyShift action_18
action_72 (31) = happyShift action_19
action_72 (33) = happyShift action_20
action_72 (36) = happyShift action_21
action_72 (39) = happyShift action_22
action_72 (7) = happyGoto action_73
action_72 (8) = happyGoto action_14
action_72 _ = happyFail

action_73 (13) = happyFail
action_73 (14) = happyFail
action_73 (15) = happyShift action_32
action_73 (16) = happyShift action_33
action_73 (17) = happyShift action_34
action_73 (18) = happyFail
action_73 (22) = happyFail
action_73 (23) = happyFail
action_73 (24) = happyFail
action_73 (25) = happyFail
action_73 (26) = happyFail
action_73 (27) = happyFail
action_73 (28) = happyFail
action_73 (29) = happyFail
action_73 (36) = happyFail
action_73 (39) = happyFail
action_73 (8) = happyGoto action_31
action_73 _ = happyReduce_22

action_74 (27) = happyShift action_79
action_74 _ = happyFail

action_75 _ = happyReduce_32

action_76 _ = happyReduce_31

action_77 (38) = happyShift action_78
action_77 _ = happyFail

action_78 _ = happyReduce_26

action_79 (14) = happyShift action_9
action_79 (6) = happyGoto action_80
action_79 _ = happyReduce_4

action_80 (35) = happyShift action_81
action_80 _ = happyFail

action_81 (13) = happyShift action_15
action_81 (14) = happyShift action_16
action_81 (20) = happyShift action_17
action_81 (30) = happyShift action_18
action_81 (31) = happyShift action_19
action_81 (33) = happyShift action_20
action_81 (36) = happyShift action_21
action_81 (39) = happyShift action_22
action_81 (7) = happyGoto action_82
action_81 (8) = happyGoto action_14
action_81 _ = happyFail

action_82 (13) = happyShift action_15
action_82 (14) = happyShift action_16
action_82 (15) = happyShift action_32
action_82 (16) = happyShift action_33
action_82 (17) = happyShift action_34
action_82 (18) = happyShift action_35
action_82 (22) = happyFail
action_82 (23) = happyShift action_37
action_82 (24) = happyShift action_38
action_82 (25) = happyShift action_39
action_82 (26) = happyShift action_40
action_82 (27) = happyShift action_41
action_82 (28) = happyShift action_42
action_82 (29) = happyShift action_43
action_82 (36) = happyShift action_21
action_82 (39) = happyShift action_22
action_82 (8) = happyGoto action_31
action_82 _ = happyReduce_33

happyReduce_1 = happySpecReduce_1  4 happyReduction_1
happyReduction_1 _
	 =  HappyAbsSyn4
		 (
	)

happyReduce_2 = happySpecReduce_3  4 happyReduction_2
happyReduction_2 _
	_
	_
	 =  HappyAbsSyn4
		 (
	)

happyReduce_3 = happyReduce 5 5 happyReduction_3
happyReduction_3 (_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (
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
happyReduction_7 _
	_
	_
	 =  HappyAbsSyn7
		 (
	)

happyReduce_8 = happySpecReduce_3  7 happyReduction_8
happyReduction_8 _
	_
	_
	 =  HappyAbsSyn7
		 (
	)

happyReduce_9 = happySpecReduce_3  7 happyReduction_9
happyReduction_9 _
	_
	_
	 =  HappyAbsSyn7
		 (
	)

happyReduce_10 = happySpecReduce_3  7 happyReduction_10
happyReduction_10 _
	_
	_
	 =  HappyAbsSyn7
		 (
	)

happyReduce_11 = happySpecReduce_3  7 happyReduction_11
happyReduction_11 _
	_
	_
	 =  HappyAbsSyn7
		 (
	)

happyReduce_12 = happySpecReduce_3  7 happyReduction_12
happyReduction_12 _
	_
	_
	 =  HappyAbsSyn7
		 (
	)

happyReduce_13 = happySpecReduce_3  7 happyReduction_13
happyReduction_13 _
	_
	_
	 =  HappyAbsSyn7
		 (
	)

happyReduce_14 = happySpecReduce_3  7 happyReduction_14
happyReduction_14 _
	_
	_
	 =  HappyAbsSyn7
		 (
	)

happyReduce_15 = happySpecReduce_3  7 happyReduction_15
happyReduction_15 _
	_
	_
	 =  HappyAbsSyn7
		 (
	)

happyReduce_16 = happySpecReduce_3  7 happyReduction_16
happyReduction_16 _
	_
	_
	 =  HappyAbsSyn7
		 (
	)

happyReduce_17 = happySpecReduce_3  7 happyReduction_17
happyReduction_17 _
	_
	_
	 =  HappyAbsSyn7
		 (
	)

happyReduce_18 = happySpecReduce_3  7 happyReduction_18
happyReduction_18 _
	_
	_
	 =  HappyAbsSyn7
		 (
	)

happyReduce_19 = happyReduce 4 7 happyReduction_19
happyReduction_19 ((HappyAbsSyn7  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn9  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (ELet nonRecursive happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_20 = happyReduce 4 7 happyReduction_20
happyReduction_20 ((HappyAbsSyn7  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn9  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (ELet recursive happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_21 = happyReduce 4 7 happyReduction_21
happyReduction_21 ((HappyAbsSyn11  happy_var_4) `HappyStk`
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

happyReduce_26 = happyReduce 6 8 happyReduction_26
happyReduction_26 (_ `HappyStk`
	(HappyTerminal (TokenInt happy_var_5)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenInt happy_var_3)) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn8
		 (EConstr happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_27 = happySpecReduce_3  8 happyReduction_27
happyReduction_27 _
	(HappyAbsSyn7  happy_var_2)
	_
	 =  HappyAbsSyn8
		 (happy_var_2
	)
happyReduction_27 _ _ _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_1  9 happyReduction_28
happyReduction_28 _
	 =  HappyAbsSyn9
		 (
	)

happyReduce_29 = happySpecReduce_3  9 happyReduction_29
happyReduction_29 _
	_
	_
	 =  HappyAbsSyn9
		 (
	)

happyReduce_30 = happySpecReduce_3  10 happyReduction_30
happyReduction_30 _
	_
	_
	 =  HappyAbsSyn10
		 (
	)

happyReduce_31 = happySpecReduce_2  11 happyReduction_31
happyReduction_31 _
	_
	 =  HappyAbsSyn11
		 (
	)

happyReduce_32 = happySpecReduce_2  11 happyReduction_32
happyReduction_32 _
	_
	 =  HappyAbsSyn11
		 (
	)

happyReduce_33 = happyReduce 6 12 happyReduction_33
happyReduction_33 (_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenInt happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (happy_var_2
	) `HappyStk` happyRest

happyNewToken action sts stk [] =
	action 43 43 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TokenInt happy_dollar_dollar -> cont 13;
	TokenSym happy_dollar_dollar -> cont 14;
	TokenAdd -> cont 15;
	TokenMin -> cont 16;
	TokenMul -> cont 17;
	TokenDiv -> cont 18;
	TokenAssign -> cont 19;
	TokenLamVars -> cont 20;
	TokenLamExpr -> cont 21;
	TokenLT -> cont 22;
	TokenLTE -> cont 23;
	TokenEQ -> cont 24;
	TokenNEQ -> cont 25;
	TokenGTE -> cont 26;
	TokenGT -> cont 27;
	TokenAnd -> cont 28;
	TokenOr -> cont 29;
	TokenLet -> cont 30;
	TokenLetRec -> cont 31;
	TokenIn -> cont 32;
	TokenCase -> cont 33;
	TokenOf -> cont 34;
	TokenArrow -> cont 35;
	TokenPack -> cont 36;
	TokenLBrace -> cont 37;
	TokenRBrace -> cont 38;
	TokenLParen -> cont 39;
	TokenRParen -> cont 40;
	TokenSemiColon -> cont 41;
	TokenComma -> cont 42;
	_ -> happyError' (tk:tks)
	}

happyError_ 43 tk tks = happyError' tks
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

