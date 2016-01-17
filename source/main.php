<?php
set_time_limit(0);
$timeout = 25; // sec
$matlabExe = '"C:\\Program Files\\MATLAB\\R2013a\\bin\\matlab.exe"';
$mFile = "'imagereader.m'";
$combine = '"run(' . $mFile . ');"';
$command = $matlabExe . ' -nodisplay -nosplash -nodesktop -r ' . $combine;

try {

    passthru($command);

    $start = time();
    while ( true ) {
        // Check if file is readable
   if (false !== ($im = @file_get_contents('output.png'))) {
        //header('Content-type:image/png');
        //echo $im;
        header('location:classify.php');
		//break;
    }

        // Check Timeout
        if ((time() - $start) > $timeout) {
            throw new Exception("Timeout Reached");
            break;
        }
    }
} catch ( Exception $e ) {
    echo $e->getMessage();
}
?>