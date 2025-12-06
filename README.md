# GTS Geometry Generator (AutoLISP)

This repository contains an AutoLISP script that generates fully parametric GTS (Ground Transportation System) geometry, based on the work of Gutierrez et al. (1995).  
The script supports customization of dimensions, optional components, symmetry operations, and export formats, making it suitable for CAD, mesh generation, and CFD workflows.

--------------------------------------
## Features

### Full Geometric Customization
- All official GTS dimensions are fully editable.
- Users can modify height, width, length, radii, wheel sizes, and all major geometric parameters.

### Wheels: Optional Component
- Generate the GTS geometry **with wheels** or **without wheels**.
- Perfect for CFD simulations with wheel simplification or ground-contact studies.

### Symmetry Mode
- Option to generate **only half** of the geometry using a symmetry cut.
- Useful for saving computational resources in symmetric flow simulations.

### Export to Multiple File Formats
- Geometry can be exported to various extensions supported by the CAD environment (e.g., "igs", "stl").
- Ideal for integrating into external modeling or meshing pipelines.

---

## Included Geometry Examples

Four ready-to-use example geometries are provided in the repository:

1. **GTS 1:1 — Half Model — Without Wheels** (halfGTSWheelsOff.dwg)
2. **GTS 1:1 — Half Model — With Wheels**    (halfGTSWheelsOn.dwg)
3. **GTS 1:1 — Full Model — Without Wheels** (fullGTSWheelsOff.dwg)
4. **GTS 1:1 — Full Model — With Wheels**    (fullGTSWheelsOn.dwg)

These examples demonstrate different configurations available through the script and serve as references for users.

---

## Reference for the Original GTS Work

Gutierrez, W. T., Hassan, B., Croll, R. H., & Rutledge, W. H.  
*Aerodynamics Overview of the Ground Transportation Systems (GTS) Project for Heavy Vehicle Drag Reduction.*  
1995.

---

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/EduardoOCarvalho/generateGTS.git

---

## Citation

If this script or the generated geometry contributes to your research, publications, or engineering work, please cite the author.
Citations help support open-source scientific tools and encourage continued development.

Recommended Citation:

Carvalho, E. O. (2025), "GTS Geometry Generator (AutoLISP Script)"
Available at: [https://github.com/EduardoOCarvalho/generateGTS](https://github.com/EduardoOCarvalho/generateGTS.git)

BibTeX:
@misc{carvalho_gts_generator_2025,
  author       = {Eduardo de Oliveira Carvalho},
  title        = {GTS Geometry Generator (AutoLISP Script)},
  year         = {2025},
  note         = {Available at GitHub},
  howpublished = {\url{https://github.com/EduardoOCarvalho/generateGTS.git}}
}

