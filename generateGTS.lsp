(defun c:generateGTS ()
  ;; ----------------------------------------------------------
  ;; Script:      generateGTS.lsp
  ;; Purpose:     Generate a GTS (Ground Transportation System)
  ;;              baseline geometry based on:
  ;;              Gutierrez, W.T., Hassan, B., Croll, R.H., & 
  ;;              Rutledge, W. H. "Aerodynamics Overview of the
  ;;              Ground  Transportation  Systems (GTS) Project  
  ;;              for Heavy Vehicle Drag Reduction," (1995).
  ;;
  ;; Details:     - Geometry generated at 1:1 scale.
  ;;              - Optional features can be enabled or disabled.
  ;;
  ;; Author:      Eduardo de Oliveira Carvalho
  ;; Affiliation: Postdoctoral Researcher, LASCA,
  ;;              Aeronautics Institute of Technology (ITA)
  ;;              São José dos Campos, São Paulo, Brazil
  ;;
  ;; Version:     1.0
  ;; Date:        06/12/2025
  ;;
  ;; License:     MIT License 
  ;; ----------------------------------------------------------
  ;;
  ;; GEOMETRY INPUTS
  ;; Total width (def. 2.5908)
  (setq GTSTW 2.5908)
  ;; Total length (def. 19.8116)
  (setq GTSTL 19.8116)
  ;; Total height (def. 3.6064)
  (setq GTSTH 3.6064)
  ;; Floor gap (def. 0.5078)
  (setq GTSFG 0.5078)
  ;; Front corner radius (def. 0.2280)
  (setq GTSCR 0.2280)
  ;; Front bottom radius (def. 0.3057)
  (setq GTSFR 0.3057)
  ;; Ellipse minor radius (def. 1.7786)
  (setq GTSSR 1.7786)
  ;; Ellipse major radius (def. 3.0480)
  (setq GTSBR 3.0480)
  ;; Cabin length (def. 5.1815)
  (setq GTSCL 5.1815)
  ;;
  ;; Number of internal sections for using loft
  ;; in the fillet edge of decaying radius (def. 20)
  (setq numLoftSect 20)
  ;;
  ;; Create wheels? (0 = No, 1 = Yes)
  (setq wheelGen 1)
  ;; The wheels are created to always touch the ground (z=0)
  ;; The wheels variables are created using lists, all lists
  ;; must have the same size
  ;; List of wheels radius (per pair)
  ;; (def 0.50780 0.50780 0.50780 0.50780 0.50780)
  (setq wheelRad (list 0.50780 0.50780 0.50780 0.50780 0.50780))
  ;; List of wheels x position
  ;; (def 0.81350 5.68930 7.01060 17.6768 18.9981)
  (setq wheelPos (list 0.81350 5.68930 7.01060 17.6768 18.9981))
  ;; List of wheels width
  ;; (def 0.25390 0.63470 0.63470 0.63470 0.63470)
  (setq wheelWid (list 0.25390 0.63470 0.63470 0.63470 0.63470))
  ;;
  ;; Scale (the scale is 1:scaleVal, always use a ".0" if the
  ;; number is an integer)
  (setq scaleVal 1.0)
  ;;
  ;; Cut the GTS model using the symmetry plane? (0 = No, 1 = Yes)
  (setq cutGTS 0)
  ;;
  ;; FILE EXPORT INPUTS
  ;; Export file? (0 = No, 1 = Yes)
  (setq expBoll 0)
  ;; File extension (examples: "igs", "stl", etc)
  (setq expFrmt "igs")
  ;; File name
  (setq expName "GTS_Geo_Test")
  ;; File address
  (setq expAddr "")
  ;;
  ;; ------------------------------------------------------
  ;; SCRIPT STARTS HERE
  ;; ------------------------------------------------------
  
  ;; Convert the units of the drawing
  (command "._-DWGUNITS"
           6      ; Set units to meters
           2      ; Unit display format
           6      ; Linear display precision
           "Y"    ; Scale objects from other drawings upon insert
           "Y"    ; Match INSUNITS to drawing units
           "Y"    ; Scale objects in the current drawing
           "Y"    ; Include objects in the Paper Space
  )

  ;; Erase all objects in the drawing (recommended)
  (command "ERASE" "ALL" "")
  
  ;; Turn off osnap in case it is turned on
  (setq osnapVal (getvar "OSMODE"))
  (if (> osnapVal 0)
      (progn
          (setvar "OSMODE" 0)
      )
  )
  
  ;; First lateral surface 
  (setq pntCrd01 (list GTSCR (* +0.5 GTSTW) GTSFG))
  (setq pntCrd02 (list GTSBR (* +0.5 GTSTW) GTSFG))
  (setq pntCrd03 (list GTSBR (* +0.5 GTSTW) (+ GTSFG GTSTH)))
  (setq pntCrd04 (list GTSCR (* +0.5 GTSTW) (+ GTSFG GTSTH)))
  (command "_.LINE" pntCrd01 pntCrd02 "")
  (setq line111 (entlast))
  (command "_.LINE" pntCrd02 pntCrd03 "")
  (setq line112 (entlast)) 
  (command "_.LINE" pntCrd03 pntCrd04 "")
  (setq line113 (entlast)) 
  (command "_.LINE" pntCrd04 pntCrd01 "")
  (setq line114 (entlast))
  (command "_.PLANESURF" "O" line111 line112 line113 line114 "" "")
  (setq surf211 (entlast))
  
  ;; Front surface
  (setq pntCrd01 (list 0 0 (+ GTSFG (- GTSTH GTSSR))))
  (setq pntCrd02 (list 0 0 (+ GTSFG GTSFR)))
  (setq pntCrd03 (list 0 (- (* +0.5 GTSTW) GTSCR) (+ GTSFG GTSFR)))
  (setq pntCrd04 (list 0 (- (* +0.5 GTSTW) GTSCR) (+ GTSFG (- GTSTH GTSSR))))
  (command "_.LINE" pntCrd01 pntCrd02 "")
  (setq line111 (entlast))
  (command "_.LINE" pntCrd02 pntCrd03 "")
  (setq line112 (entlast)) 
  (command "_.LINE" pntCrd03 pntCrd04 "")
  (setq line113 (entlast)) 
  (command "_.LINE" pntCrd04 pntCrd01 "")
  (setq line114 (entlast))
  (command "_.PLANESURF" "O" line111 line112 line113 line114 "" "")
  (setq surf341 (entlast))
  
  ;; Bottom-front corner arc
  (command "_.ARC" "C"
           (list GTSFR 0 (- (+ GTSFG GTSFR) (* +0.5 GTSTW)))
           (list 0 0 (- (+ GTSFG GTSFR) (* +0.5 GTSTW)))
           "A" 90 "")

  (command "_.ROTATE3D" (entlast) "" "X"
          (list 0 0 (+ GTSFG GTSFR))
          90)
    
  
  (command "_.EXTRUDE" (entlast) "" (* 0.5 GTSTW))
  (setq arcBottom (entlast))
  
  ;; A-pillar corner arc
  (command "_.ARC" "C"
           (list GTSCR (- (* +0.5 GTSTW) GTSCR) GTSFG)
           (list GTSCR (* +0.5 GTSTW) GTSFG)
           "A" 90 "")
  (setq arcPillarA01 (entlast))
  (command "_.EXTRUDE" arcPillarA01 "" (- GTSTH GTSSR))
  (setq arcPillarA01 (entlast))
  
  ;; Basis arc and straigth lines to create the windshield
  (command "_.ARC" "C"
           (list GTSCR (- (* +0.5 GTSTW) GTSCR) (- (+ GTSFG GTSTH) GTSSR))
           (list GTSCR (* +0.5 GTSTW) (- (+ GTSFG GTSTH) GTSSR))
           "A" 90 "")
  (setq arcPillarA12 (entlast))
  (command "_.LINE" 
           (list 0 (- (* +0.5 GTSTW) GTSCR) (- (+ GTSFG GTSTH) GTSSR))
           (list 0 0 (- (+ GTSFG GTSTH) GTSSR)) "")
  (setq windshield (entlast))
  (command "_.PEDIT" arcPillarA12 "Y" "J" windshield "" "")
  (setq windshield (entlast))
  
  ;; Sweep ellipse path creation
  (command "_.ELLIPSE" "A"
           (list GTSBR (- (- (* +0.5 GTSTW) GTSSR) GTSCR) (- (+ GTSFG GTSTH) GTSSR))
           (list GTSBR (- (+ (* +0.5 GTSTW) GTSSR) GTSCR) (- (+ GTSFG GTSTH) GTSSR))
            GTSBR 90 180)
  (command "_.ROTATE3D" (entlast) "" "X"
          (list GTSBR (- (* +0.5 GTSTW) GTSCR) (- (+ GTSFG GTSTH) GTSSR))
          90)
  
  ;; Sweep to create the windshield front and lateral surfaces
  (command "_.SWEEP" windshield "" (entlast) "")
  (setq windshield (entlast))
  
  ;; Creation of the fillet edge with decaying radius
  
  ;; Guide list for the loft operation
  (setq guideList '())
  
  ;; Creating the first section using an arc
  ;; (connection with the cabin)
  (command "_.ARC" "C"
           (list GTSBR (- (* +0.5 GTSTW) GTSCR) (- (+ GTSFG GTSTH) GTSCR))
           (list GTSBR (* +0.5 GTSTW) (- (+ GTSFG GTSTH) GTSCR))
           "A" 90 "")
  (command "_.ROTATE3D" (entlast) "" "Y"
          (list GTSBR (- (* +0.5 GTSTW) GTSCR) (- (+ GTSFG GTSTH) GTSCR))
          90)
  (setq decaySweepArcBase (entlast))
  (setq guideList (append guideList (list (entlast))))
  
  ;; Loop for the creation of the inner sections
  ;; converting an arc into the meeting of two
  ;; straight lines
  (setq xNow GTSBR)
  (setq rNow GTSCR)
  (setq xStep (/ (- GTSCL GTSBR) (+ numLoftSect 1)))
  (setq rStep (/ GTSCR (+ numLoftSect 1)))
  (repeat numLoftSect
        (setq xNow (+ xNow xStep))
        (setq rNow (- rNow rStep))
        (command "_.LINE" 
           (list (- xNow rNow) (- (* +0.5 GTSTW) GTSCR) (- (+ GTSFG GTSTH) rNow))
           (list (- xNow rNow) (- (* +0.5 GTSTW) rNow)  (- (+ GTSFG GTSTH) rNow)) "")
        (setq loftSuport01 (entlast))
        (command "_.ARC" "C"
           (list xNow (- (* +0.5 GTSTW) rNow) (- (+ GTSFG GTSTH) rNow))
           (list xNow (* +0.5 GTSTW) (- (+ GTSFG GTSTH) rNow))
           "A" 90 "")
        (setq loftSuport02 (entlast))
        (command "_.LINE" 
           (list xNow (* +0.5 GTSTW) (- (+ GTSFG GTSTH) rNow))
           (list (+ xNow (- GTSCR rNow)) (* +0.5 GTSTW) (- (+ GTSFG GTSTH) rNow)) "")
        (setq loftSuport03 (entlast))
        (command "_.PEDIT" loftSuport01 "Y" "J" loftSuport02 loftSuport03 "" "")
        (command "_.ROTATE3D" (entlast) "" "Y"
           (list xNow (- (* +0.5 GTSTW) rNow) (- (+ GTSFG GTSTH) rNow))
           90 "")
        (setq guideList (append guideList (list (entlast))))
  )
  
  ;; Creation of the final section with two straight lines
  (command "_.LINE" 
     (list (- GTSCL GTSCR) (- (* +0.5 GTSTW) GTSCR) (-(+ GTSFG GTSTH) GTSCR))
     (list (- GTSCL GTSCR) (* +0.5 GTSTW)  (- (+ GTSFG GTSTH) GTSCR)) "")
  (setq loftSuport01 (entlast))
  (command "_.LINE" 
     (list (- GTSCL GTSCR) (* +0.5 GTSTW)  (- (+ GTSFG GTSTH) GTSCR))
     (list GTSCL (* +0.5 GTSTW)  (- (+ GTSFG GTSTH) GTSCR)) "")
  (setq loftSuport03 (entlast))
  (command "_.PEDIT" loftSuport01 "Y" "J" loftSuport03 "" "")
  (command "_.ROTATE3D" (entlast) "" "Y"
     (list GTSCL (* +0.5 GTSTW) (- (+ GTSFG GTSTH) GTSCR))
     90 "")
  (setq guideList (append guideList (list (entlast))))
  
  ;; Finishing the creation of the surface using loft
  (apply 'command
       (append (list "_.LOFT")
               guideList
               (list "") (list "")))
  
  ;; Second lateral surface
  (setq pntCrd01 (list GTSBR (* +0.5 GTSTW) GTSFG))
  (setq pntCrd02 (list GTSCL (* +0.5 GTSTW) GTSFG))
  (setq pntCrd03 (list GTSCL (* +0.5 GTSTW) (-(+ GTSFG GTSTH) GTSCR)))
  (setq pntCrd04 (list GTSBR (* +0.5 GTSTW) (-(+ GTSFG GTSTH) GTSCR)))
  (command "_.LINE" pntCrd01 pntCrd02 "")
  (setq line111 (entlast))
  (command "_.LINE" pntCrd02 pntCrd03 "")
  (setq line112 (entlast)) 
  (command "_.LINE" pntCrd03 pntCrd04 "")
  (setq line113 (entlast)) 
  (command "_.LINE" pntCrd04 pntCrd01 "")
  (setq line114 (entlast))
  (command "_.PLANESURF" "O" line111 line112 line113 line114 "" "")
  (setq surf212 (entlast))
  
  ;; Second top surface
  (setq pntCrd01 (list GTSCL 0 (+ GTSFG GTSTH)))
  (setq pntCrd02 (list GTSBR 0 (+ GTSFG GTSTH)))
  (setq pntCrd03 (list GTSBR (- (* +0.5 GTSTW) GTSCR) (+ GTSFG GTSTH)))
  (setq pntCrd04 (list GTSCL (- (* +0.5 GTSTW) GTSCR) (+ GTSFG GTSTH)))
  (command "_.LINE" pntCrd01 pntCrd02 "")
  (setq line111 (entlast))
  (command "_.LINE" pntCrd02 pntCrd03 "")
  (setq line112 (entlast)) 
  (command "_.LINE" pntCrd03 pntCrd04 "")
  (setq line113 (entlast)) 
  (command "_.LINE" pntCrd04 pntCrd01 "")
  (setq line114 (entlast))
  (command "_.PLANESURF" "O" line111 line112 line113 line114 "" "")
  (setq surf332 (entlast))
  
  ;; Third lateral surface 
  (setq pntCrd01 (list GTSCL (* +0.5 GTSTW) GTSFG))
  (setq pntCrd02 (list GTSTL (* +0.5 GTSTW) GTSFG))
  (setq pntCrd03 (list GTSTL (* +0.5 GTSTW) (+ GTSFG GTSTH)))
  (setq pntCrd04 (list GTSCL (* +0.5 GTSTW) (+ GTSFG GTSTH)))
  (command "_.LINE" pntCrd01 pntCrd02 "")
  (setq line111 (entlast))
  (command "_.LINE" pntCrd02 pntCrd03 "")
  (setq line112 (entlast)) 
  (command "_.LINE" pntCrd03 pntCrd04 "")
  (setq line113 (entlast)) 
  (command "_.LINE" pntCrd04 pntCrd01 "")
  (setq line114 (entlast))
  (command "_.PLANESURF" "O" line111 line112 line113 line114 "" "")
  (setq surf213 (entlast))
  
  ;; First rear surface
  (setq pntCrd01 (list GTSTL 0 GTSFG))
  (setq pntCrd02 (list GTSTL 0 (+ GTSFG GTSTH)))
  (setq pntCrd03 (list GTSTL (* +0.5 GTSTW) (+ GTSFG GTSTH)))
  (setq pntCrd04 (list GTSTL (* +0.5 GTSTW) GTSFG))
  (command "_.LINE" pntCrd01 pntCrd02 "")
  (setq line111 (entlast))
  (command "_.LINE" pntCrd02 pntCrd03 "")
  (setq line112 (entlast)) 
  (command "_.LINE" pntCrd03 pntCrd04 "")
  (setq line113 (entlast)) 
  (command "_.LINE" pntCrd04 pntCrd01 "")
  (setq line114 (entlast))
  (command "_.PLANESURF" "O" line111 line112 line113 line114 "" "")
  (setq surf321 (entlast))
  
  ;; Third top surface
  (setq pntCrd01 (list GTSTL 0 (+ GTSFG GTSTH)))
  (setq pntCrd02 (list GTSCL 0 (+ GTSFG GTSTH)))
  (setq pntCrd03 (list GTSCL (* +0.5 GTSTW) (+ GTSFG GTSTH)))
  (setq pntCrd04 (list GTSTL (* +0.5 GTSTW) (+ GTSFG GTSTH)))
  (command "_.LINE" pntCrd01 pntCrd02 "")
  (setq line111 (entlast))
  (command "_.LINE" pntCrd02 pntCrd03 "")
  (setq line112 (entlast)) 
  (command "_.LINE" pntCrd03 pntCrd04 "")
  (setq line113 (entlast)) 
  (command "_.LINE" pntCrd04 pntCrd01 "")
  (setq line114 (entlast))
  (command "_.PLANESURF" "O" line111 line112 line113 line114 "" "")
  (setq surf333 (entlast))
  
  ;; First bottom surface
  (setq pntCrd01 (list GTSFR 0 GTSFG))
  (setq pntCrd02 (list GTSTL 0 GTSFG))
  (setq pntCrd03 (list GTSTL (* +0.5 GTSTW) GTSFG))
  (setq pntCrd04 (list GTSFR (* +0.5 GTSTW) GTSFG))
  (command "_.LINE" pntCrd01 pntCrd02 "")
  (setq line111 (entlast))
  (command "_.LINE" pntCrd02 pntCrd03 "")
  (setq line112 (entlast)) 
  (command "_.LINE" pntCrd03 pntCrd04 "")
  (setq line113 (entlast)) 
  (command "_.LINE" pntCrd04 pntCrd01 "")
  (setq line114 (entlast))
  (command "_.PLANESURF" "O" line111 line112 line113 line114 "" "")
  (setq surf311 (entlast))
  
  ;; Adding the wheels
  (if (= wheelGen 1)
    (progn 
      (setq wheelIndex 0)
      (repeat (length wheelRad)
        (command "_.CYLINDER"
                 (list (nth wheelIndex wheelPos)
                       (- (* +0.5 GTSTW) (nth wheelIndex wheelWid))
                       (nth wheelIndex wheelRad))
                 (nth wheelIndex wheelRad)
                  "A"
                 (list (nth wheelIndex wheelPos)
                       (* +0.5 GTSTW)
                       (nth wheelIndex wheelRad)))
        
        (setq wheelIndex (+ wheelIndex 1))
      )
    ) 
  )
  
  
  ;; Cut the GTS by the symmetry plane or use the full model
  (if (= cutGTS 1)
    (progn
      ;; First symmetry surface
      (setq pntCrd01 (list 0 0 GTSFG))
      (setq pntCrd02 (list GTSTL 0 GTSFG))
      (setq pntCrd03 (list GTSTL 0 (+ GTSFG GTSTH)))
      (setq pntCrd04 (list 0 0 (+ GTSFG GTSTH)))
      (command "_.LINE" pntCrd01 pntCrd02 "")
      (setq line111 (entlast))
      (command "_.LINE" pntCrd02 pntCrd03 "")
      (setq line112 (entlast)) 
      (command "_.LINE" pntCrd03 pntCrd04 "")
      (setq line113 (entlast)) 
      (command "_.LINE" pntCrd04 pntCrd01 "")
      (setq line114 (entlast))
      (command "_.PLANESURF" "O" line111 line112 line113 line114 "" "")
      (setq surf111 (entlast))
    )
    (progn
      (command "._MIRROR3D" "ALL" "" "ZX" (list 0.0 0.0 0.0) "N")
    )
  )
  
  ;; Join everthing in a 3D solid
  (command "._SURFSCULPT" "ALL" "")

  ;; Remove all objects that are no 3D solid
  (setq ss (ssget "X" '((-4 . "<NOT") (0 . "3DSOLID") (-4 . "NOT>"))))
  (if ss
    (repeat (setq i (sslength ss))
      (setq ent (ssname ss (setq i (1- i))))
      (entdel ent)
    )
  )
  
  ;; Scale Geometry
  (if (= scaleVal 1.0)
    (progn )
    (progn
      (setq scaleVal (/ 1.0 scaleVal))
      (command "._SCALE" "ALL" "" (list 0 0 0) scaleVal)
    )
  )
  ;; Export file
  (if (= expBoll 1)
    (progn
      ;; Build full file path with extension
      (setq fullPath (strcat expAddr expName "." expFrmt))

      ;; Call EXPORT command
      (command "_.EXPORT" fullPath "ALL" "")
    )
  )
  
  ;; Turn the onsnap back on again
  (if (> osnapVal 0)
      (progn
          (setvar "OSMODE" osnapVal)
      )
  )
)
