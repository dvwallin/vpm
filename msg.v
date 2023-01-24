module main
fn introduction(){
    println('Thank you for using vpm.')
    println('If you have any questions, please send an email to 1814888800@qq.com')
}
fn store_exist_warning(){
    println('$pkg_name already exist!')
}
fn store_init_warning(){
    println('$pkg_name create failed!')
}
fn store_init_success(){
    println('$pkg_name init success')
}

fn fetch_done(lib_name string){
    println('fetch "$lib_name" done')
}

fn command_not_found(cmd string){
    println('command "$cmd" not found')
}

fn install_complete(){
    println('install done')
}

fn load_store_failed(){
    println('load $pkg_name failed!')
}
