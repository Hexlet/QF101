(* Content-type: application/vnd.wolfram.cdf.text *)

(*** Wolfram CDF File ***)
(* http://www.wolfram.com/cdf *)

(* CreatedBy='Mathematica 9.0' *)

(*************************************************************************)
(*                                                                       *)
(*  The Mathematica License under which this file was created prohibits  *)
(*  restricting third parties in receipt of this file from republishing  *)
(*  or redistributing it by any means, including but not limited to      *)
(*  rights management or terms of use, without the express consent of    *)
(*  Wolfram Research, Inc. For additional information concerning CDF     *)
(*  licensing and redistribution see:                                    *)
(*                                                                       *)
(*        www.wolfram.com/cdf/adopting-cdf/licensing-options.html        *)
(*                                                                       *)
(*************************************************************************)

(*CacheID: 234*)
(* Internal cache information:
NotebookFileLineBreakTest
NotebookFileLineBreakTest
NotebookDataPosition[      1063,         20]
NotebookDataLength[      9182,        234]
NotebookOptionsPosition[      9551,        223]
NotebookOutlinePosition[     10115,        246]
CellTagsIndexPosition[     10072,        243]
WindowFrame->Normal*)

(* Beginning of Notebook Content *)
Notebook[{

Cell[CellGroupData[{
Cell[BoxData[
 RowBox[{"Manipulate", "[", 
  RowBox[{
   RowBox[{"Plot", "[", 
    RowBox[{
     RowBox[{
      RowBox[{
       SubscriptBox["N", "1"], "\[Times]", 
       RowBox[{"Max", "[", 
        RowBox[{
         RowBox[{"S", "-", 
          SubscriptBox["K", "1"]}], ",", "0"}], "]"}]}], "+", 
      RowBox[{
       SubscriptBox["N", "2"], "\[Times]", 
       RowBox[{"Max", "[", 
        RowBox[{
         RowBox[{"S", "-", 
          SubscriptBox["K", "2"]}], ",", "0"}], "]"}]}], "+", 
      RowBox[{
       SubscriptBox["N", "3"], "\[Times]", 
       RowBox[{"Min", "[", 
        RowBox[{
         RowBox[{
          SubscriptBox["K", "3"], "-", "S"}], ",", "0"}], "]"}]}], "+", 
      RowBox[{
       SubscriptBox["N", "4"], "\[Times]", 
       RowBox[{"Min", "[", 
        RowBox[{
         RowBox[{
          SubscriptBox["K", "4"], "-", "S"}], ",", "0"}], "]"}]}]}], ",", 
     "\[IndentingNewLine]", 
     RowBox[{"{", 
      RowBox[{"S", ",", "0", ",", "100"}], "}"}], ",", "\[IndentingNewLine]", 
     RowBox[{"PlotLabel", "\[Rule]", 
      RowBox[{"StringForm", "[", 
       RowBox[{
       "\"\<`` Calls@``, `` Calls@``, `` Puts@``, `` Puts@``\>\"", ",", 
        SubscriptBox["N", "1"], ",", 
        SubscriptBox["K", "1"], ",", 
        SubscriptBox["N", "2"], ",", 
        SubscriptBox["K", "2"], ",", 
        SubscriptBox["N", "3"], ",", 
        SubscriptBox["K", "3"], ",", 
        SubscriptBox["N", "4"], ",", 
        SubscriptBox["K", "4"]}], "]"}]}]}], "\[IndentingNewLine]", "]"}], 
   ",", "\[IndentingNewLine]", 
   RowBox[{"{", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{
       SubscriptBox["K", "1"], ",", "50", ",", 
       "\"\<Call Option 1 Strike\>\""}], "}"}], ",", "0", ",", "100", ",", 
     "10"}], "}"}], ",", "\[IndentingNewLine]", 
   RowBox[{"{", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{
       SubscriptBox["N", "1"], ",", "1", ",", 
       "\"\<Number of call options at this strike\>\""}], "}"}], ",", "0", 
     ",", "5", ",", "1"}], "}"}], ",", "\[IndentingNewLine]", 
   RowBox[{"{", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{
       SubscriptBox["K", "2"], ",", "50", ",", 
       "\"\<Call Option 2 Strike\>\""}], "}"}], ",", "0", ",", "100", ",", 
     "10"}], "}"}], ",", "\[IndentingNewLine]", 
   RowBox[{"{", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{
       SubscriptBox["N", "2"], ",", "0", ",", 
       "\"\<Number of call options at this strike\>\""}], "}"}], ",", "0", 
     ",", "5", ",", "1"}], "}"}], ",", "\[IndentingNewLine]", 
   RowBox[{"{", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{
       SubscriptBox["K", "3"], ",", "50", ",", 
       "\"\<Put Option 1 Strike\>\""}], "}"}], ",", "0", ",", "100", ",", 
     "10"}], "}"}], ",", "\[IndentingNewLine]", 
   RowBox[{"{", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{
       SubscriptBox["N", "3"], ",", "0", ",", 
       "\"\<Number of put options at this strike\>\""}], "}"}], ",", "0", ",",
      "5", ",", "1"}], "}"}], ",", "\[IndentingNewLine]", 
   RowBox[{"{", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{
       SubscriptBox["K", "4"], ",", "50", ",", 
       "\"\<Put Option 2 Strike\>\""}], "}"}], ",", "0", ",", "100", ",", 
     "10"}], "}"}], ",", "\[IndentingNewLine]", 
   RowBox[{"{", 
    RowBox[{
     RowBox[{"{", 
      RowBox[{
       SubscriptBox["N", "4"], ",", "0", ",", 
       "\"\<Number of put options at this strike\>\""}], "}"}], ",", "0", ",",
      "5", ",", "1"}], "}"}]}], "\[IndentingNewLine]", "]"}]], "Input", \
"PluginEmbeddedContent"],

Cell[BoxData[
 TagBox[
  StyleBox[
   DynamicModuleBox[{$CellContext`$236$$ = 40, $CellContext`$237$$ = 
    2, $CellContext`$238$$ = 60, $CellContext`$239$$ = 
    0, $CellContext`$240$$ = 50, $CellContext`$241$$ = 
    0, $CellContext`$242$$ = 50, $CellContext`$243$$ = 0, Typeset`show$$ = 
    True, Typeset`bookmarkList$$ = {}, Typeset`bookmarkMode$$ = "Menu", 
    Typeset`animator$$, Typeset`animvar$$ = 1, Typeset`name$$ = 
    "\"untitled\"", Typeset`specs$$ = {{{
       Hold[$CellContext`$236$$], 50, "Call Option 1 Strike"}, 0, 100, 10}, {{
       Hold[$CellContext`$237$$], 1, "Number of call options at this strike"},
       0, 5, 1}, {{
       Hold[$CellContext`$238$$], 50, "Call Option 2 Strike"}, 0, 100, 10}, {{
       Hold[$CellContext`$239$$], 0, "Number of call options at this strike"},
       0, 5, 1}, {{
       Hold[$CellContext`$240$$], 50, "Put Option 1 Strike"}, 0, 100, 10}, {{
       Hold[$CellContext`$241$$], 0, "Number of put options at this strike"}, 
      0, 5, 1}, {{
       Hold[$CellContext`$242$$], 50, "Put Option 2 Strike"}, 0, 100, 10}, {{
       Hold[$CellContext`$243$$], 0, "Number of put options at this strike"}, 
      0, 5, 1}}, Typeset`size$$ = {360., {120., 123.}}, Typeset`update$$ = 0, 
    Typeset`initDone$$, Typeset`skipInitDone$$ = 
    True, $CellContext`$236$49676$$ = 0, $CellContext`$237$49677$$ = 
    0, $CellContext`$238$49678$$ = 0, $CellContext`$239$49679$$ = 
    0, $CellContext`$240$49680$$ = 0, $CellContext`$241$49681$$ = 
    0, $CellContext`$242$49682$$ = 0, $CellContext`$243$49683$$ = 0}, 
    DynamicBox[Manipulate`ManipulateBoxes[
     1, StandardForm, 
      "Variables" :> {$CellContext`$236$$ = 50, $CellContext`$237$$ = 
        1, $CellContext`$238$$ = 50, $CellContext`$239$$ = 
        0, $CellContext`$240$$ = 50, $CellContext`$241$$ = 
        0, $CellContext`$242$$ = 50, $CellContext`$243$$ = 0}, 
      "ControllerVariables" :> {
        Hold[$CellContext`$236$$, $CellContext`$236$49676$$, 0], 
        Hold[$CellContext`$237$$, $CellContext`$237$49677$$, 0], 
        Hold[$CellContext`$238$$, $CellContext`$238$49678$$, 0], 
        Hold[$CellContext`$239$$, $CellContext`$239$49679$$, 0], 
        Hold[$CellContext`$240$$, $CellContext`$240$49680$$, 0], 
        Hold[$CellContext`$241$$, $CellContext`$241$49681$$, 0], 
        Hold[$CellContext`$242$$, $CellContext`$242$49682$$, 0], 
        Hold[$CellContext`$243$$, $CellContext`$243$49683$$, 0]}, 
      "OtherVariables" :> {
       Typeset`show$$, Typeset`bookmarkList$$, Typeset`bookmarkMode$$, 
        Typeset`animator$$, Typeset`animvar$$, Typeset`name$$, 
        Typeset`specs$$, Typeset`size$$, Typeset`update$$, Typeset`initDone$$,
         Typeset`skipInitDone$$}, "Body" :> 
      Plot[$CellContext`$237$$ 
         Max[$CellContext`S - $CellContext`$236$$, 0] + $CellContext`$239$$ 
         Max[$CellContext`S - $CellContext`$238$$, 0] + $CellContext`$241$$ 
         Min[$CellContext`$240$$ - $CellContext`S, 0] + $CellContext`$243$$ 
         Min[$CellContext`$242$$ - $CellContext`S, 0], {$CellContext`S, 0, 
         100}, PlotLabel -> 
        StringForm[
         "`` Calls@``, `` Calls@``, `` Puts@``, `` Puts@``", \
$CellContext`$237$$, $CellContext`$236$$, $CellContext`$239$$, \
$CellContext`$238$$, $CellContext`$241$$, $CellContext`$240$$, \
$CellContext`$243$$, $CellContext`$242$$]], 
      "Specifications" :> {{{$CellContext`$236$$, 50, "Call Option 1 Strike"},
          0, 100, 
         10}, {{$CellContext`$237$$, 1, 
          "Number of call options at this strike"}, 0, 5, 
         1}, {{$CellContext`$238$$, 50, "Call Option 2 Strike"}, 0, 100, 
         10}, {{$CellContext`$239$$, 0, 
          "Number of call options at this strike"}, 0, 5, 
         1}, {{$CellContext`$240$$, 50, "Put Option 1 Strike"}, 0, 100, 
         10}, {{$CellContext`$241$$, 0, 
          "Number of put options at this strike"}, 0, 5, 
         1}, {{$CellContext`$242$$, 50, "Put Option 2 Strike"}, 0, 100, 
         10}, {{$CellContext`$243$$, 0, 
          "Number of put options at this strike"}, 0, 5, 1}}, "Options" :> {},
       "DefaultOptions" :> {}],
     ImageSizeCache->{818., {151., 156.}},
     SingleEvaluation->True],
    Deinitialization:>None,
    DynamicModuleValues:>{},
    SynchronousInitialization->True,
    UnsavedVariables:>{Typeset`initDone$$},
    UntrackedVariables:>{Typeset`size$$}], "Manipulate",
   Deployed->True,
   StripOnInput->False],
  Manipulate`InterpretManipulate[1]]], "Output", "PluginEmbeddedContent"]
}, {2}]]
},
WindowSize->{871, 575},
WindowMargins->{{516, Automatic}, {Automatic, 183}},
Visible->True,
AuthoredSize->{871.32, 575.27},
ScrollingOptions->{"HorizontalScrollRange"->Fit,
"VerticalScrollRange"->Fit},
ShowCellBracket->False,
Deployed->True,
CellContext->Notebook,
TrackCellChangeTimes->False,
FrontEndVersion->"9.0 for Microsoft Windows (64-bit) (November 20, 2012)",
StyleDefinitions->"Default.nb"
]
(* End of Notebook Content *)

(* Internal cache information *)
(*CellTagsOutline
CellTagsIndex->{}
*)
(*CellTagsIndex
CellTagsIndex->{}
*)
(*NotebookFileOutline
Notebook[{
Cell[CellGroupData[{
Cell[1485, 35, 3533, 102, 257, "Input"],
Cell[5021, 139, 4517, 81, 309, "Output"]
}, {2}]]
}
]
*)

(* End of internal cache information *)

(* NotebookSignature QwDChlUrMHXChC1ZlbnPlY15 *)
