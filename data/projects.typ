#let projects = (
  (
    id: "fynix",
    title: "Fynix",
    status: "Active",
    desc: "A composable, declarative UI framework powering the entire Forge ecosystem.",
    link: "https://github.com/voxell-tech/fynix",
    milestones: (
      (
        "TypeSlot & Typed Table Optimization",
        "done",
        "Implementing faster specialized tables (ElementTable, InteractionTable, EventTable) for types known at link time.",
      ),
      (
        "Element Composers",
        "active",
        "Creating the Composer trait to cleanly separate required caller inputs from styleable element data.",
      ),
      (
        "Unit System",
        "planned",
        "Implementation of the core unit system.",
      ),
      (
        "Interactions & Events",
        "planned",
        "Adding world-agnostic handlers via proc-macros and a Fynix-owned Events queue for outgoing UI-to-world messages.",
      ),
      (
        "Reactivity (Signals)",
        "active",
        "Implementing field signals and reactive scopes.",
      ),
    ),
  ),
  (
    id: "velyst",
    title: "Velyst",
    status: "Active",
    desc: "Interactive Typst content creator using Vello and Bevy.",
    link: "https://github.com/voxell-tech/velyst",
    milestones: (
      (
        "World Space 2D Coordinate Support",
        "active",
        "Enable positioning and transformations relative to the global coordinate system.",
      ),
    ),
  ),
  (
    id: "xad",
    title: "Xad",
    status: "Active",
    desc: "A modern precision modeling software with an SDF-based approach.",
    link: "https://github.com/voxell-tech/xad",
    milestones: (
      (
        "SDF Kernel Setup",
        "active",
        "Core mathematical functions for Signed Distance Fields.",
      ),
      (
        "Node Graph Implementation",
        "active",
        "Asset/scene representation format to serialize/deserialize files.",
      ),
      (
        "Constraint Solver",
        "active",
        "Precise geometric relationships, dimensional limits and parametric links.",
      ),
      (
        "Direct Slider Integration",
        "planned",
        "Able to export SDF to STEP files & being able to slice the SDFs directly.",
      ),
    ),
  ),
  (
    id: "motiongfx",
    title: "MotionGfx",
    status: "Active",
    desc: "Backend agnostic motion graphics creation framework.",
    link: "https://github.com/voxell-tech/motiongfx",
    milestones: (
      (
        "Typst Support",
        "active",
        "Native Typst support will bring typeset content (equations, charts, rich text) into MotionGfx",
      ),
      (
        "UI Editor",
        "planned",
        "Develop a visual UI editor that allows users to create, edit and preview motion graphics through an intuitive interface.",
      ),
    ),
  ),
)
