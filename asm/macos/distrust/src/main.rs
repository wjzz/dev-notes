use std::env;
use std::process;

fn main() {
    let args: Vec<String> = env::args().skip(1).collect();

    if args.len() != 1 {
        println!("Usage: <path-to-binary>");
        process::exit(1);
    }

    let file_name = &args[0];
    let bytes: Vec<u8> = read_file_as_bytes(file_name);

    process_bytes(bytes);
}

fn read_file_as_bytes(file_name: &str) -> Vec<u8> {
    std::fs::read(file_name).expect("No file found")
}

fn process_bytes(bytes: Vec<u8>) {
    println!("Found {} bytes", bytes.len());
    println!("===============");
    for byte in bytes.iter() {
        println!("{}", byte);
    }
}
