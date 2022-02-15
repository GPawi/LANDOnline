LANDO: Linked age-depth modeling
========
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/GPawi/LANDOnline/main?labpath=LANDO.ipynb)
[![DOI](https://zenodo.org/badge/432999664.svg)](https://zenodo.org/badge/latestdoi/432999664)

<!-- LOGO -->
<div id="top" align = "right"> 
<img src='src/LANDO_Logo.jpg' align="right" height="120" />
</div>

<!-- ABOUT THE PROJECT -->
## About the project

**LANDO** links the most commonly used age-depth modeling software in one multi-language Jupyter Notebook, known as [_SoS notebook_](https://github.com/vatlab/sos-notebook) (Peng et al., 2018). Due to its design, the notebook uses four Jupyter kernels: Python, R, Octave, and MATLAB. We implemented the following modeling systems in **LANDO**:  
   	* [_Bacon_](https://github.com/Maarten14C/rbacon) (Blaauw and Christen, 2011),  
   	* [_Bchron_](https://github.com/andrewcparnell/Bchron) (Haslett and Parnell, 2008; Parnell et al., 2008),  
   	* [_clam_](https://github.com/Maarten14C/clam) (Blaauw, 2010),  
   	* [_hamstr_](https://github.com/EarthSystemDiagnostics/hamstr) (Dolman, 2021),  
   	* [_Undatable_](https://github.com/bryanlougheed/undatable) (Lougheed and Obrochta, 2019).  
Furthermore, **LANDO** uses the [fuzzy changepoint](https://github.com/mjhollaway/Fuzzy_cpt_eval) method by Holloway et al. (2021) to evaluate the performance of modeling systems to represent lithological change based on independent proxy data. **LANDO** can run models for single or multiple sediment cores.

<!-- ABOUT THE REPOSITORY -->
## About the repository

In this repository we try to publish an online running version of LANDO. For the stand-alone version, please go to [https://github.com/GPawi/LANDO](https://github.com/GPawi/LANDO)


<!-- PREREQUISITES -->
## _Prerequisites_

We used the following programming languages versions to develop **LANDO**:  

Programming language | Version  
:---- | ----: 
R | 4.1.2  
Python | 3.9 
Octave | 6.4.0 
MATLAB[^1] | 2020b  

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- USAGE OF LANDO -->
## _Run LANDO_

Open your `Anaconda Powershell Prompt` or `Terminal`(and start conda). Then change to the directory of the LANDO-main repository. Activate your environment and lunch Jupyter Notebook. In our working example, we use a **Windows** machine, the `Anaconda Powershell Prompt` and the LANDO-main folder on another drive: 

~~~
> pushd E:/LANDO-main
> conda activate LANDO
> jupyter notebook
~~~

Launch **LANDO** by clicking on LANDO.ipynb.

There are four ways to retrieve age determination data: 

Input | Code  
:---- | :---- 
Data for one single core from file | `dates = gd.AgeFromFileOneCore()` 
Data for multiple cores from file | `dates = gd.AgeFromFileMultiCore()`  
Data for one single core from a database | `dates = gd.AgeFromDBOneCore()`  
Data for multiple cores from a database | `dates = gd.AgeFromDBMultiCore()`

And two ways to retrieve proxy data:

Input | Code  
:---- | :---- 
Data from file | `proxy = gd.ProxyFromFile()` 
Data from database | `proxy = gd.ProxyFromDB()` 

There are different parameters that can be adjusted for each modeling software in LANDO

Modeling software | Parameter | Default value
:---- | :---- | ----:
_Bacon_ | acc.shape | 1.5
_Bacon_ | acc.mean | 20
_Bacon_ | mem.strength | 10
_Bacon_ | mem.mean | 0.5
_Bacon_ | ssize | 8000
_clam_ | types_curve | 1:5
_clam_ | smoothness_curve | 0.1*(1:10)
 _clam_| poly\_degree_curve | 1:4
_hamstr_ | K | c(10,10)
_Undatable_ | xfactor | 0.1
_Undatable_ | bootpc | 30 

If you want to know more about the implemented functions, please use the `help()` function in Python. For instance, using `help(age_sr_plot.PlotAgeSR.plot_graph)` returns:

> Help on function plot\_graph in module src.age\_sr_plot:

> plot\_graph(self, orig\_dir, sigma\_range='both', bin\_size=1000, xlim\_max=None, number\_col=7, reduce\_plot\_axis=False, only\_combined=False, save=False, for\_color_blind=False, as\_jpg=False)  
    Main function to plot data for single core and multi-core case
    
> parameters:  
    @self.orig\_dir: original directory where LANDO was launched, so that plots can be saved to the folder "output\_figures"  
    @self.sigma\_range: sigma range that should be shown in the plot - the options are: 'both', '1sigma', '2sigma', and None  
    @self.bin\_size: this argument only works for the multi-core case; defines the bin size in years; default value: 1000  
    @self.xlim\_max: this argument only works for the multi-core case; defines the maximum age range in years to be plotted; default value: None  
    @self.number\_col: only works for the multi-core case; defines the number of columns to plot; default value: 7  
    @self.reduce\_plot\_axis: only works for the multi-core case; reduces the number that are plotted on the axis; default value: False  
    @self.only\_combined: argument to decide if only combined model should be plotted; default value: False  
    @self.save: argument to decide if plot should be saved to location given in orig\_dir; default value: False  
    @self.for\_color\_blind: argument to transform plot to be suitable for people with color vision deficiency; default value: False  
    @self.as\_jpg: argument to plot grafics as .jpg (default is .pdf), which works best for color-blind plot; default value: False  
    
> returns:
    Main output plot from LANDO

You can close the notebook using `File` --> `Close and halt`. On the main page click on `Quit` and close the tab. Enter `exit` in the `Anaconda Powershell Prompt` or `Terminal` to stop conda. In case of hidden running processes, use `Alt`+`F4` (**Windows**) or `command`+`Q` (**macOS**).

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- FUTURE PLANS -->
## Future Plans

* Add OxCal to LANDO  

See the [open issues](https://github.com/GPawi/LANDO/issues) for a full list of proposed features (and known issues).

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- LICENSE -->
## License

Distributed under the GNU GPLv3 License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- CONTACT -->
## Contact

Gregor Pfalz - Gregor.Pfalz@awi.de - [@ClimateCompathy](https://twitter.com/ClimateCompathy)

Project Link: [https://github.com/GPawi/LANDO](https://github.com/GPawi/LANDO)

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- REFERENCES -->
## References

Blaauw, M.: Methods and code for “classical” age-modelling of radiocarbon sequences, Quat. Geochronol., 5, 512–518, [https://doi.org/10.1016/j.quageo.2010.01.002](https://doi.org/10.1016/j.quageo.2010.01.002), 2010.

Blaauw, M. and Christen, J. A.: Flexible paleoclimate age-depth models using an autoregressive gamma process, Bayesian Anal., 6, 457–474, [https://doi.org/10.1214/11-BA618](https://doi.org/10.1214/11-BA618), 2011.

Dolman, A. M.: hamstr: Hierarchical Accumulation Modelling with Stan and R, [https://github.com/EarthSystemDiagnostics/hamstr](https://github.com/EarthSystemDiagnostics/hamstr), 2021.

Haslett, J. and Parnell, A.: A simple monotone process with application to radiocarbon-dated depth chronologies, J. R. Stat. Soc. Ser. C Appl. Stat., 57, 399–418, [https://doi.org/10.1111/j.1467-9876.2008.00623.x](https://doi.org/10.1111/j.1467-9876.2008.00623.x), 2008.

Hollaway, M. J., Henrys, P. A., Killick, R., Leeson, A., and Watkins, J.: Evaluating the ability of numerical models to capture important shifts in environmental time series: A fuzzy change point approach, Environ. Model. Softw., 139, 104993, [https://doi.org/10.1016/j.envsoft.2021.104993](https://doi.org/10.1016/j.envsoft.2021.104993), 2021.

Lougheed, B. C. and Obrochta, S. P.: A Rapid, Deterministic Age-Depth Modeling Routine for Geological Sequences With Inherent Depth Uncertainty, Paleoceanogr. Paleoclimatology, 34, 122–133, [https://doi.org/10.1029/2018PA003457](https://doi.org/10.1029/2018PA003457), 2019.

Parnell, A. C., Haslett, J., Allen, J. R. M., Buck, C. E., and Huntley, B.: A flexible approach to assessing synchroneity of past events using Bayesian reconstructions of sedimentation history, Quat. Sci. Rev., 27, 1872–1885, [https://doi.org/10.1016/j.quascirev.2008.07.009](https://doi.org/10.1016/j.quascirev.2008.07.009), 2008.

Peng, B., Wang, G., Ma, J., Leong, M. C., Wakefield, C., Melott, J., Chiu, Y., Du, D., and Weinstein, J. N.: SoS notebook: An interactive multi-language data analysis environment, 34, 3768–3770, [https://doi.org/10.1093/bioinformatics/bty405](https://doi.org/10.1093/bioinformatics/bty405), 2018.

<p align="right">(<a href="#top">back to top</a>)</p>


[^1]: Since we want to keep LANDO open source, the installation process does not include instructions for the MATLAB kernel. If you have an active MATLAB license, please follow the instructions on the [SoS notebook website](https://vatlab.github.io/sos-docs/running.html#-matlab). We provide the necessary code to run the MATLAB version of Undatable in the repository, which can replace the Octave version.