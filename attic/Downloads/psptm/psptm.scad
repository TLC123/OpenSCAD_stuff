/***************************************************************************//**
  \file   psptm.scad
  \author Roy Allen Sutton
  \date   2017

  \copyright
    [Creative Commons Attribution-ShareAlike]
    (https://creativecommons.org/licenses/by-sa/3.0/legalcode)

  \brief
    Portable solar panel tripod mount.
*******************************************************************************/

/***************************************************************************//**
  \mainpage Main Page
  \tableofcontents

  \section description Description

    Wanted a portable articulating mount for a 5 watt solar panel that
    charges a small power system that I use when camping. Decided on a
    design that made use of a broken tripod and sturdy but lightweight
    poles from an old folding camping chair that were lying around
    awaiting to be re-purposed.

    \htmlonly
      \amu_image_table (
          type=html image_width="240" table_caption="Non-printed Parts"
          cell_files="system.jpg tripod.jpg chair.jpg"
          cell_captions="System^Tripod^Chair" )
    \endhtmlonly
    \latexonly
      \amu_image_table (
          type=latex image_width="1.50in" table_caption="Non-printed Parts"
          cell_files="system.jpg tripod.jpg chair.jpg"
          cell_captions="System^Tripod^Chair" )
    \endlatexonly

    The top of the tripod was cut off with a hack saw and four straight
    tube segments were cut from the folding chair as needed to assemble
    the panel support frame. The lengths will depend on the dimensions
    of your panel.

  \subsection result Result

    Here is the resulting design.

    \amu_define stl_dl_mesg (click image to download STL file)

    \htmlonly
      \amu_image_table (
          type=html image_width="320" table_caption="Assembled Product"
          cell_files="result1.jpg result2.jpg"
          cell_captions="View 1^View 2" )
    \endhtmlonly
    \latexonly
      \amu_image_table (
          type=latex image_width="2.00in" table_caption="Assembled Product"
          cell_files="result1.jpg result2.jpg"
          cell_captions="View 1^View 2" )
    \endlatexonly

    \htmlonly
      \amu_image_table (
          type=html image_width="320" table_caption="Assembled Design Model (${stl_dl_mesg})"
          cell_files="psptm_assembled_right_1024x768.png
                      psptm_assembled_pole_right_1024x768.png"
          cell_urls="psptm_assembled.stl psptm_assembled_pole.stl"
          cell_captions="Assembled Parts^Parts with Poles" )
    \endhtmlonly
    \latexonly
      \amu_image_table (
          type=latex image_width="2.00in" table_caption="Assembled Design Model"
          cell_files="psptm_assembled_right_1024x768.eps
                      psptm_assembled_pole_right_1024x768.eps"
          cell_captions="Assembled Parts^Parts with Poles" )
    \endlatexonly

  \subsection parts Parts

    There are 14 total printed parts and 7 types as shown in the following
    table. There are three version for part number 2 and 5 (I was not sure
    if a printed open frame would be study enough so I generated closed
    versions). I am using version d1 for both parts as it turned out to
    be sufficient for my use. For convenience several build plates have
    been rendered that include the required parts.

    \amu_define part_titles ( p1: Pole Cap - qty 1^
                              p2d1: Pole Bracket - qty 1^
                              p2d2: Pole Bracket - qty 1^
                              p2d3: Pole Bracket - qty 1^
                              p3: Pole Nut - qty 1^
                              p4: Pole Knobs - qty 1 set^
                              p5d1: Panel Bracket - qty 1^
                              p5d2: Panel Bracket - qty 1^
                              p5d3: Panel Bracket - qty 1^
                              p6: Panel Tee - qty 4^
                              p7: Panel Mount - qty 4^
                              Build Plate - 174x194x71mm^
                              Build Plate 1 of 2 - 146x129x35mm^
                              Build Plate 2 of 2 - 138x109x71mm)
    \amu_eval    part_names ( pole_cap
                              pole_bracket_d1 pole_bracket_d2 pole_bracket_d3
                              pole_nut pole_knobs
                              panel_bracket_d1 panel_bracket_d2 panel_bracket_d3
                              panel_tee panel_mount
                              build_all build_1of2 build_2of2 )
    \amu_combine  png_files ( prefix=psptm "${part_names}" suffix="_diag_1024x768.png" separator=" ")
    \amu_combine  stl_files ( prefix=psptm "${part_names}" suffix=".stl" separator=" ")

    \amu_shell     file_cnt ( "echo ${png_files} | wc -w" )
    \amu_shell    cell_cnts ( "seq -f '(%g)' -s '^' ${file_cnt}" )

    \htmlonly
      \amu_image_table
        (
          type=html columns=3 image_width="320" table_caption="Design Parts (${stl_dl_mesg})"
          cell_files="${png_files}" cell_urls="${stl_files}"
          cell_captions="${part_titles}" cell_titles="${cell_cnts}"
        )
    \endhtmlonly

    \amu_combine  eps_files ( prefix=psptm "${part_names}" suffix="_diag_1024x768.eps" separator=" ")
    \latexonly
      \amu_image_table
        (
          type=latex columns=3 image_width="1.5in" table_caption="Design Parts"
          cell_files="${eps_files}"
          cell_captions="${part_titles}" cell_titles="${cell_cnts}"
        )
    \endlatexonly

  \subsection parameters Parameters

    The design parameters can be easily modified in one location for the
    tube dimensions you have on hand (ie: EMT, rigid, ABS, copper, etc).
    As rendered, it makes use of M3 hex-bolt socket-head cap-screws and
    hux-nuts, although this too can be reconfigured via root parameters.

    \amu_table
    (
      columns=3
      column_headings="Parameter^Current Design Value^Description"
      cell_texts="
        base_unit_length^mm^design base units^

        hcf^1 + 4/100^bolt hole clearance factor^
        bcf^1 + 2/100^bracket pivot clearance factor^
        fcf^1 + 14/100^bracket pivot finger clearance factor^

        bolt^nutbolt_3mm^pole clamp hardware (7-tuple, see source)^

        spole_mt^4 mm^support pole fittings material thickness^
        spole_diameter^20 + 1/2 mm^support pole diameter^
        spole_insert^spole_diameter * 2^support pole insert depth^

        spole_notch^2mm x 9mm^support pole notch dimensions^
        bpole_mt^2 + 1/2 mm^panel pole fittings material thickness^
        bpole_diameter^17 + 7/8 mm^panel pole diameter
      "
    )

    When modifying the parameters for your sizes, be sure to check the
    resulting fit with a sample print of a test fitting (ie panel_tee)
    before printing a build plate! Try to insert the pole into the side
    without the tab first to make sure it passes freely but snuggly in
    the fitting.

  \subsection time Time

    The total render time for all the parts in the table above on a 1.6Ghz
    AMD E-350 dual core processor running Linux is summarized below:

    \amu_table
    (
      columns=3
      column_headings="Elapsed time^User time^System time"
      cell_texts="318m 40.379s^580m 48.948s^4m 25.644s"
    )

    The [openscad-amu] design flow will dispatch a separate render process
    for each compute core/thread of your CPU. This is why the Elapsed time
    is roughly half of the total user time on this dual core system. This
    dramatically reduces the total build times for multi-part designs on
    multi-processor system.

    Here is a breakdown of [OpenSCAD] render times, by part (The reduced
    CPU usage for the first several parts were due to system time sharing
    during this writeup).

    \amu_table
    (
      columns=6
      column_headings="
        Part ID^Elapsed time (h:mm:ss)^User time (s)^System time (s)^
        CPU use (%)^Memory Max. (KB)
      "
      cell_texts="
        psptm_assembled_pole^2:47:11^8777.90^82.84^88%^3005816^
        psptm_assembled^2:40:55^8453.30^77.08^88%^2503588^
        psptm_build_1of2^54:05.61^3147.12^13.37^97%^2216748^
        psptm_build_2of2^35:09.63^2049.29^5.85^97%^1532896^
        psptm_build_all^1:34:29^5630.57^7.19^99%^3399788^
        psptm_panel_bracket_d1^13:55.22^829.20^1.96^99%^1247092^
        psptm_panel_bracket_d2^12:50.97^765.79^2.05^99%^1231040^
        psptm_panel_bracket_d3^13:25.89^801.30^1.81^99%^1225344^
        psptm_panel_mount^3:43.91^222.04^0.83^99%^586756^
        psptm_panel_tee^9:42.08^578.83^1.34^99%^864232^
        psptm_pole_bracket_d1^2:20.80^139.30^0.50^99%^414632^
        psptm_pole_bracket_d2^2:02.54^121.26^0.50^99%^349924^
        psptm_pole_bracket_d3^2:01.11^120.11^0.48^99%^340284^
        psptm_pole_cap^4:27.57^265.68^0.98^99%^664500^
        psptm_pole_knobs^5:11.75^309.73^0.96^99%^662996^
        psptm_pole_nut^5:39.39^337.00^0.94^99%^660408^
      "
    )

    The time from concept to finished assembly and writeup took
    approximately 48 hours over a few days. The [omdl] design library
    and the [openscad-amu] design tools greatly reduced the overall
    effort to both design and document this result. I imagine that this
    solution could be used in other scenarios that seek to mount an
    articulating panel to a vertical post. Let me know what you come up
    with!

  \section dependencies Dependencies

    To re-render the printed parts you will need to obtain [omdl], version
    0.4, and [mstscrewlib]. To use the auto recompilation and/or rebuild
    this documentation, you will need to obtain and install [openscad-amu].
    This design was completed using version 1.7 of the tools. There is
    a learning curve to getting started with them, but it seems as though
    the payoff over time is worth it.

    Once [omdl], [mstscrewlib], and [openscad-amu] are installed, the
    build process is a simple as:

    \code{.bash}
    $ make info                               # (design flow information)
    $ make all                                # (build everything)
    $ firefox build_1.0/html/index.html       # (view this documentation)
    \endcode

    This will render all of the design parts, the assembled demo, the
    build plate, and this documentation.

    Once done, use your favorite browser to review the documentation.

  \section template Template

    To use [Doxygen] to document your [OpenSCAD] designs or utilize a
    similar auto design flow, see the introduction to [openscad-amu]
    and design [template]. If you release a design that uses [omdl] or
    [openscad-amu] support these efforts by tagging your design with
    \em omdl and/or \em openscad-amu.

    [omdl]: https://github.com/royasutton/omdl
    [openscad-amu]: https://github.com/royasutton/openscad-amu
    [template]: http://www.thingiverse.com/thing:1858181
    [OpenSCAD]: http://www.openscad.org/
    [Doxygen]: http://www.stack.nl/~dimitri/doxygen/index.html
    [mstscrewlib]: http://www.thingiverse.com/thing:1714053

*******************************************************************************/

include <psptm_parts.scad>;

$fn               = 36;                                 //!< arch rendering segments

base_unit_length  = "mm";                               //!< design base units

hcf               = 1 + 4/100;                          //!< bolt hole clearance factor
bcf               = 1 + 2/100;                          //!< bracket pivot clearance factor
fcf               = 1 + 14/100;                         //!< bracket pivot finger clearance factor

//
// design configuration parameters
//

// bolt hardware
nutbolt_3mm       =                                     //!< M3 hex bolt/nut specification
[
  ["bd", hcf * convert_length(3, "mm")],                //!< \b bd: bolt diameter,
  ["hd", hcf * convert_length(5 + 1/2, "mm")],          //!< \b hd: bolt head diameter,
  ["hh", hcf * convert_length(3, "mm")],                //!< \b hh: bolt head height,
  ["nf", hcf * convert_length(5 + 1/2, "mm")],          //!< \b nf: nut diameter flats,
  ["np", hcf * convert_length(5 + 1/2, "mm")/ sin(60)], //!< \b np: nut diameter points,
  ["nh", hcf * convert_length(3, "mm")],                //!< \b nh: nut height,
  ["ns", 6]                                             //!< \b ns: nut sides
];

map_check(nutbolt_3mm);                                 //!< Check nut specification map

// vertical support pole
spole_mt          = convert_length(4, "mm");            //!< support pole fittings material thickness
spole_diameter    = convert_length(20 + 1/2, "mm");     //!< support pole diameter
spole_insert      = spole_diameter * 2;                 //!< support pole insert depth
spole_notch       =                                     //!< support pole notch dimensions
[
  convert_length(2, "mm"),                              //!< slot depth,
  convert_length(9, "mm")                               //!< slot width
];

// panel bracket poles
bpole_mt          = convert_length(2 + 1/2, "mm");      //!< panel pole fittings material thickness
bpole_diameter    = convert_length(17 + 7/8, "mm");     //!< panel pole diameter

//
// configured part rendering
//

//! Render all parts assembled together.
module assembled(show_poles=true)
{
  px = convert_length(15 + 1/2, "cm");
  py = (show_poles == true ) ? convert_length(32, "cm") : px;

  my = bpole_diameter * 3;

  for (j=[[-1, 0, false], [+1, 180, true]])
  translate([0, first(j)*px/2, 0])
  rotate([second(j), 0, 0])
  {
    if (show_poles)
    color("gray")
    cylinder(d=bpole_diameter, h=py, center=true);

    for (i=[[+1, 0, false], [-1, 180, true]])
    translate([0, 0, first(i)*(py/2 - bpole_diameter)])
    rotate([0, second(i), 270])
    part_panel(mirror_x=last(i));

    for (i=[[+1, 0, false], [-1, 180, true]])
    translate([0, 0, first(i)*(my/2)])
    rotate([0, second(i), 0])
    part_tee(mirror_x=last(i), origin="assemble");
  }

  if (show_poles)
  for (i=[+1, -1])
  color("gray")
  translate([0, 0, i * my/2])
  rotate([90, 0, 0])
  cylinder(d=bpole_diameter, h=px - bpole_diameter, center=true);

  rotate([90, 0, 90])
  part_bracket(origin="assemble");

  translate([0, 0, -px/2 - spole_insert])
  rotate([0, 0, -90])
  part_pole(origin="assemble", parts=["pole", "bracket", "nut", "knobs"]);
}

//! Render all parts arranged on 3D printer build plate.
module build(mode)
{
  mx = bpole_diameter * 4;
  my = bpole_diameter * 3;

  px = mx * 2;
  py = my * 3;

  // build plate all parts
  if (mode == 0)
  {
    sx1 = bpole_diameter * 2.0;
    sy1 = bpole_diameter * 2.0;

    st_cartesian_copy([4,2], [sx1, sy1])
    {
      part_panel(mirror_x=true, id="b");
      part_panel(mirror_x=true, id="b");
      part_panel(mirror_x=false, id="a");
      part_panel(mirror_x=false, id="a");

      part_tee(mirror_x=false, origin="build", id="a");
      part_tee(mirror_x=false, origin="build", id="a");
      part_tee(mirror_x=true, origin="build", id="b");
      part_tee(mirror_x=true, origin="build", id="b");
    }

    translate([sx1 * 3.5, sy1 * 3.25, 0,])
    part_pole(origin="build", parts=["knobs"]);

    sx2 = bpole_diameter * 4.0;
    sy2 = bpole_diameter * 3.0;

    translate([0, sy1*2.5])
    st_cartesian_copy([2,2], [sx2, sy2])
    {
      part_pole(origin="build", parts=["pole"]);
      part_pole(origin="build", parts=["nut"]);
      part_pole(origin="build", parts=["bracket"], id="d1");
      part_bracket(origin="build", id="d1");
    }
  }

  // build plate 1 of 2
  if (mode == 1)
  {
    sx = bpole_diameter * 2.0;
    sy = bpole_diameter * 2.0;

    st_cartesian_copy([4,2], [sx, sy])
    {
      part_panel(mirror_x=true, id="b");
      part_panel(mirror_x=true, id="b");
      part_panel(mirror_x=false, id="a");
      part_panel(mirror_x=false, id="a");

      part_tee(mirror_x=false, origin="build", id="a");
      part_tee(mirror_x=false, origin="build", id="a");
      part_tee(mirror_x=true, origin="build", id="b");
      part_tee(mirror_x=true, origin="build", id="b");
    }
    translate([sx * 1.5, -sy * 1.25, 0,])
    rotate([0, 0, 90])
    part_pole(origin="build", parts=["knobs"]);
  }

  // build plate 2 of 2
  if (mode == 2)
  {
    sx = bpole_diameter * 4.0;
    sy = bpole_diameter * 3.0;

    st_cartesian_copy([2,2], [sx, sy])
    {
      part_pole(origin="build", parts=["pole"]);
      part_pole(origin="build", parts=["nut"]);
      part_pole(origin="build", parts=["bracket"], id="d1");
      part_bracket(origin="build", id="d1");
    }
  }
}

//! Render configured support pole parts.
module part_pole(origin="build", parts=["pole"], conf=[true, true], id)
{
  pole
  (
    mt = spole_mt,
    diameter = spole_diameter,
    insert = spole_insert,
    notch = spole_notch,
    bolt = nutbolt_3mm,
    bp_mt = bpole_mt,
    bp_diameter = bpole_diameter,
    parts = parts,
    conf = conf,
    origin = origin,
    id = id
  );
}

//! Render configured panel bracket.
module part_bracket(origin="build", conf=[true, true], id)
{
  bracket
  (
    mt = bpole_mt,
    diameter = bpole_diameter,
    bolt = nutbolt_3mm,
    conf = conf,
    origin = origin,
    id = id
  );
}

//! Render configured panel frame tee.
module part_tee(mirror_x=false, origin="build", id)
{
  tee
  (
    mt = bpole_mt,
    diameter = bpole_diameter,
    bolt = nutbolt_3mm,
    mirror_x = mirror_x,
    origin = origin,
    id = id
  );
}

//! Render configured panel frame mount fitting.
module part_panel(mirror_x=false, id)
{
  panel
  (
    mt = bpole_mt,
    diameter = bpole_diameter,
    bolt = nutbolt_3mm,
    mirror_x = mirror_x,
    id = id
  );
}

//! Design main, render a named part.
module main(part)
{
  log_echo(str("Rendering part [", part, "].") );
  // demo assemblies
       if (part == "assembled_pole")    assembled(show_poles=true);
  else if (part == "assembled")         assembled(show_poles=false);
  // build plates
  else if (part == "build_all")         build(0);
  else if (part == "build_1of2")        build(1);
  else if (part == "build_2of2")        build(2);
  // parts
  else if (part == "pole_cap")          part_pole(parts=["pole"]);
  else if (part == "pole_bracket_d1")   part_pole(parts=["bracket"], conf=[true, true], id="d1");
  else if (part == "pole_bracket_d2")   part_pole(parts=["bracket"], conf=[true, false], id="d2");
  else if (part == "pole_bracket_d3")   part_pole(parts=["bracket"], conf=[false, false], id="d3");
  else if (part == "pole_knobs")        part_pole(parts=["knobs"]);
  else if (part == "pole_nut")          part_pole(parts=["nut"]);
  else if (part == "panel_bracket_d1")  part_bracket(conf=[true, true], id="d1");
  else if (part == "panel_bracket_d2")  part_bracket(conf=[true, false], id="d2");
  else if (part == "panel_bracket_d3")  part_bracket(conf=[false, false], id="d3");
  else if (part == "panel_tee")         part_tee();
  else if (part == "panel_mount")       part_panel();
  // warn unknown
  else    log_warn(str("Part [", part, "] unknown.") );
}

//! Design version string (updated by auto-build script).
version = "0.0";

//! Log version reported by Project Makefile
log_info(str("design version = ", version));

//! Part name to render.
part = "assembled_pole";

main(part=part);

// -------------------------------------------------------------------------- //
// openscad-amu auxiliary auto-build script
// -------------------------------------------------------------------------- //

/*

BEGIN_SCOPE render;
  BEGIN_MFSCRIPT;
    views   NAME "views" VIEWS "top right diag";
    images  NAME "sizes" ASPECT "4:3" Wsizes "1024";
    defines NAME "part" DEFINE "part"
      STRINGS
      "
        assembled_pole
        assembled
        build_all
        build_1of2
        build_2of2
        pole_cap
        pole_bracket_d1
        pole_bracket_d2
        pole_bracket_d3
        pole_knobs
        pole_nut
        panel_bracket_d1
        panel_bracket_d2
        panel_bracket_d3
        panel_tee
        panel_mount
      ";

    variables
      SET_MAKEFILE "${__MAKE_FILE__}"  ADD_DEPEND "${__MAKE_FILE__}"
      SET_SOURCE "${__SOURCE_FILE__}"  SET_PREFIX "${__PREFIX__}"

      SET_EXT "png"
      SET_CONVERT_EXTS "eps"  SET_CONVERT_OPTS "-verbose"
      SET_OPTS "--preview --projection=o --viewall --autocenter"
      ADD_OPTS "-D version=\\\"${version}\\\""
      SET_OPTS_COMBINE "part views sizes";

    script
      BEGIN_MAKEFILE_NEW
        INCLUDE_COPY "${__AMU_INCLUDE_PATH__}/parallel_jobs.mk"
        SUMMARY  TABLES  TARGETS  MENU_EXT
      END_MAKEFILE;

    variables
      SET_EXT "stl"
      CLEAR_CONVERT
      SET_OPTS "--render"
      ADD_OPTS "-D version=\\\"${version}\\\""
      SET_OPTS_COMBINE "part";

    script
      BEGIN_MAKEFILE_APPEND
        SUMMARY  TABLES  TARGETS  MENU_EXT  MENU_SRC  MENU_ALL
      END_MAKEFILE;
  END_MFSCRIPT;
END_SCOPE;
*/

////////////////////////////////////////////////////////////////////////////////
// end of file
////////////////////////////////////////////////////////////////////////////////
