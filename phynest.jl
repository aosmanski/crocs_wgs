using PhyNEST
using Distributed
using ArgParse
using LinearAlgebra

function parse_commandline()
    s = ArgParseSettings()

    @add_arg_table s begin
        "--phylip", "-p"
            help = "Phylip file"
            required = true
        "--tree", "-t"
            help = "Newick tree file"
            required = true
        "--outgroup", "-o"
            help = "Outgroup"
            required = true
        "--cpus", "-c"
            help = "Number of CPUs (threads) to use"
            arg_type = Int
            default = Threads.nthreads()
    end

    return parse_args(s)
end

function main()
    # Parse the command-line arguments
    parsed_args = parse_commandline()

    # Get the argument values
    phylip_file = parsed_args["phylip"]
    newick_tree = parsed_args["tree"]
    outgroup = parsed_args["outgroup"]
    num_threads = parsed_args["cpus"]

    # Set the number of threads to use
#    BLAS.set_num_threads(num_threads)
    num_processors=Distributed.nprocs(8)

    # Read the Phylip data and starting topology
    phylip_data = readPhylip(phylip_file)
    starting_topology = readTopology(newick_tree)

    # Run phyne! with the provided arguments and distribute the computation across threads
    net1 = @distributed (+) for i in 1:num_threads
        phyne!(starting_topology, phylip_data, outgroup)
    end

    # Print the resulting network
    println(net1)
end

main()
