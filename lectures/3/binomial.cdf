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
NotebookDataLength[      7414,        166]
NotebookOptionsPosition[      7750,        157]
NotebookOutlinePosition[      8418,        181]
CellTagsIndexPosition[      8375,        178]
WindowFrame->Normal*)

(* Beginning of Notebook Content *)
Notebook[{
Cell[BoxData[
 TagBox[
  StyleBox[
   DynamicModuleBox[{$CellContext`d$$ = 0.91, $CellContext`r$$ = 
    0.1, $CellContext`S$$ = 50, $CellContext`t$$ = 2, $CellContext`u$$ = 
    1.1, $CellContext`X$$ = 50, $CellContext`z$$ = 1, Typeset`show$$ = True, 
    Typeset`bookmarkList$$ = {}, Typeset`bookmarkMode$$ = "Menu", 
    Typeset`animator$$, Typeset`animvar$$ = 1, Typeset`name$$ = 
    "\"untitled\"", Typeset`specs$$ = {{{
       Hold[$CellContext`t$$], 2, "periods"}, {1, 2, 3, 4}}, {{
       Hold[$CellContext`u$$], 1.1, "up factor"}, 1.01, 2, 0.01}, {{
       Hold[$CellContext`d$$], 0.91, "down factor"}, 0.5, 0.99, 0.01}, {{
       Hold[$CellContext`r$$], 0.1, "one-period interest rate"}, 0.01, 0.25, 
      0.01}, {{
       Hold[$CellContext`S$$], 50, "initial price of underlying"}, 10, 100}, {{
       Hold[$CellContext`X$$], 50, "exercise (or strike) price"}, 10, 100}, {{
       Hold[$CellContext`z$$], 1, "type of option"}, {
      1 -> "call", -1 -> "put"}}}, Typeset`size$$ = {632., {191., 196.}}, 
    Typeset`update$$ = 0, Typeset`initDone$$, Typeset`skipInitDone$$ = 
    True, $CellContext`t$637$$ = 0, $CellContext`u$638$$ = 
    0, $CellContext`d$639$$ = 0, $CellContext`r$640$$ = 
    0, $CellContext`S$641$$ = 0, $CellContext`X$642$$ = 
    0, $CellContext`z$643$$ = False}, 
    DynamicBox[Manipulate`ManipulateBoxes[
     1, StandardForm, 
      "Variables" :> {$CellContext`d$$ = 0.91, $CellContext`r$$ = 
        0.1, $CellContext`S$$ = 50, $CellContext`t$$ = 2, $CellContext`u$$ = 
        1.1, $CellContext`X$$ = 50, $CellContext`z$$ = 1}, 
      "ControllerVariables" :> {
        Hold[$CellContext`t$$, $CellContext`t$637$$, 0], 
        Hold[$CellContext`u$$, $CellContext`u$638$$, 0], 
        Hold[$CellContext`d$$, $CellContext`d$639$$, 0], 
        Hold[$CellContext`r$$, $CellContext`r$640$$, 0], 
        Hold[$CellContext`S$$, $CellContext`S$641$$, 0], 
        Hold[$CellContext`X$$, $CellContext`X$642$$, 0], 
        Hold[$CellContext`z$$, $CellContext`z$643$$, False]}, 
      "OtherVariables" :> {
       Typeset`show$$, Typeset`bookmarkList$$, Typeset`bookmarkMode$$, 
        Typeset`animator$$, Typeset`animvar$$, Typeset`name$$, 
        Typeset`specs$$, Typeset`size$$, Typeset`update$$, Typeset`initDone$$,
         Typeset`skipInitDone$$}, "Body" :> ($CellContext`singlenode[{
           Pattern[$CellContext`Vd$, 
            Blank[]], 
           Pattern[$CellContext`Vu$, 
            
            Blank[]]}] := -(($CellContext`Vd$ - \
$CellContext`Vu$)/(-$CellContext`d$$ + $CellContext`u$$)) - ($CellContext`u$$ \
$CellContext`Vd$ - $CellContext`d$$ $CellContext`Vu$)/((
          1 + $CellContext`r$$) ($CellContext`d$$ - $CellContext`u$$)); \
$CellContext`finalnodes := Map[Table[
           
           Max[$CellContext`z$$ ($CellContext`S$$ \
$CellContext`u$$^$CellContext`m $CellContext`d$$^(# - $CellContext`m) - \
$CellContext`X$$), 0], {$CellContext`m, 0, #}]& , {1, 2, 3, 
          4}]; $CellContext`nodes[
          Pattern[$CellContext`l, 
           Blank[List]]] := Table[
          $CellContext`singlenode[
           Part[
            Table[{
              Part[$CellContext`l, $CellContext`i], 
              Part[$CellContext`l, $CellContext`i + 1]}, {$CellContext`i, 
              Length[$CellContext`l] - 1}], $CellContext`j]], {$CellContext`j,
            Length[$CellContext`l] - 1}]; $CellContext`optionrules[
          Pattern[$CellContext`t, 
           Blank[]]] := 
        Part[{2 -> 1, 3 -> 1, 4 -> 2, 5 -> 2, 5 -> 3, 6 -> 3, 7 -> 4, 8 -> 4, 
           8 -> 5, 9 -> 5, 9 -> 6, 10 -> 6, 11 -> 7, 12 -> 7, 12 -> 8, 13 -> 
           8, 13 -> 9, 14 -> 9, 14 -> 10, 15 -> 10}, 
          Range[
           Part[$CellContext`nr, $CellContext`t]]]; $CellContext`nr = {2, 6, 
         12, 20}; $CellContext`nn = {3, 6, 10, 15}; TreePlot[
         ReplaceAll[
          $CellContext`optionrules[$CellContext`t$$], 
          Table[Part[
             Range[
              Part[$CellContext`nn, $CellContext`t$$]], $CellContext`i] -> 
           NumberForm[
             Part[
              Flatten[
               Reverse[
                NestList[$CellContext`nodes, 
                 
                 Part[$CellContext`finalnodes, $CellContext`t$$], \
$CellContext`t$$]]], $CellContext`i], 4], {$CellContext`i, 
            Part[$CellContext`nn, $CellContext`t$$]}]], Left, DirectedEdges -> 
         True, VertexLabeling -> True, AspectRatio -> 0.75, PlotLabel -> Style[
           Row[{"option value = ", 
             NumberForm[
              Part[
               Nest[$CellContext`nodes, 
                
                Part[$CellContext`finalnodes, $CellContext`t$$], \
$CellContext`t$$], 1], 4]}], "Label"], ImageSize -> {350, 350}]), 
      "Specifications" :> {{{$CellContext`t$$, 2, "periods"}, {1, 2, 3, 4}, 
         ControlType -> SetterBar}, {{$CellContext`u$$, 1.1, "up factor"}, 
         1.01, 2, 0.01, Appearance -> "Labeled", ImageSize -> 
         Tiny}, {{$CellContext`d$$, 0.91, "down factor"}, 0.5, 0.99, 0.01, 
         Appearance -> "Labeled", ImageSize -> 
         Tiny}, {{$CellContext`r$$, 0.1, "one-period interest rate"}, 0.01, 
         0.25, 0.01, Appearance -> "Labeled", ImageSize -> 
         Tiny}, {{$CellContext`S$$, 50, "initial price of underlying"}, 10, 
         100, Appearance -> "Labeled", ImageSize -> 
         Tiny}, {{$CellContext`X$$, 50, "exercise (or strike) price"}, 10, 
         100, Appearance -> "Labeled", ImageSize -> 
         Tiny}, {{$CellContext`z$$, 1, "type of option"}, {
         1 -> "call", -1 -> "put"}, ControlType -> RadioButtonBar}}, 
      "Options" :> {
       ControlPlacement -> Left, 
        TrackedSymbols :> {$CellContext`t$$, $CellContext`u$$, \
$CellContext`d$$, $CellContext`r$$, $CellContext`S$$, $CellContext`X$$, \
$CellContext`z$$}, AutorunSequencing -> {1, 3, 5}}, 
      "DefaultOptions" :> {ControllerLinking -> True}],
     ImageSizeCache->{951., {222., 227.}},
     SingleEvaluation->True],
    Deinitialization:>None,
    DynamicModuleValues:>{},
    SynchronousInitialization->True,
    UnsavedVariables:>{Typeset`initDone$$},
    UntrackedVariables:>{Typeset`size$$}], "Manipulate",
   Deployed->True,
   StripOnInput->False],
  Manipulate`InterpretManipulate[1]]], "Output", "PluginEmbeddedContent"]
},
WindowSize->{1012, 464},
WindowMargins->{{445, Automatic}, {Automatic, 239}},
Visible->True,
AuthoredSize->{1012.3000000000001`, 464.53000000000003`},
ScrollingOptions->{"HorizontalScrollRange"->Fit,
"VerticalScrollRange"->Fit},
ShowCellBracket->False,
Deployed->True,
CellContext->Notebook,
TrackCellChangeTimes->False,
FrontEndVersion->"9.0 for Microsoft Windows (64-bit) (November 20, 2012)",
StyleDefinitions->FrontEnd`FileName[{"Wolfram"}, "Demonstration.nb", 
  CharacterEncoding -> "WindowsANSI"]
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
Cell[1463, 33, 6283, 122, 451, "Output"]
}
]
*)

(* End of internal cache information *)

(* NotebookSignature 1xDwpCqd2gfq5BgUdjFePAxE *)
