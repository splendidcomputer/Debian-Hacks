mkdir -p ../unziped-CARDIODE400
for f in *.zip; do
    name="${f%.zip}"                # strip .zip extension
    outdir="../unziped-CARDIODE400/$name"
    mkdir -p "$outdir"
    unzip -q "$f" -d "$outdir"
done

