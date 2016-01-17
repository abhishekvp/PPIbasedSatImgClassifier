<?php
set_time_limit(0);
$timeout = 100; // sec
$output = 'C:\ms4w\Apache\htdocs\manish\samplePHPscripts\processed_file\ans.png';
$matlabExe = '"D:\\matlab2013\\bin\\matlab.exe"';
$mFile = "'PROSPECT5_Matlab_inversion\invleafP5B.m'";
$combine = '"run(' . $mFile . ');"';
$command = $matlabExe . ' -nodisplay -nosplash -nodesktop -r ' . $combine;

try {
    if (! @unlink($output) && is_file($output))
        throw new Exception("Unable to remove old file");

    passthru($command);

    $start = time();
    while ( true ) {
        // Check if file is readable
        if (is_file($output) && is_readable($output)) {
            $img = @imagecreatefrompng($output);
            // Check if Math Lab is has finished writing to image
            if ($img !== false) {
				$stage = $_POST["growthStage"];
                header('location:result.php?stage='.$stage);
				//header('Content-type:image/png');
                //imagepng($img);
                break;
            }
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