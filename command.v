module main
fn cmd_version(){
    println('vpm version $version')
}

fn cmd_help(){
    println('Currently supported commands:')
    println('vpm -v/version             - show the vpm version info')
    println('vpm init <project name>    - create the $pkg_name file')
    println('vpm get <git-url> <name>   - fetch package from the git repo')
    println('vpm install                - reads the $pkg_name file and install packages')
    println('vpm -h/help                - show the help message')
    println('vpm clean                  - remove the $pkg_name file')
    println('vpm ls                     - show installed packages list')
    println('vpm rm <package ...>       - remove packages in the $pkg_name file by name')
}

fn cmd_clean(){
    rm_store_path()
    println('vpm clean success')
}

fn cmd_init(args []string){
    if check_store_exist(){
        store_exist_warning()
        return
    }
    mut name:=get_default_project_name()
    if args.len>2 && args[2]!=''{
        name=args[2]
    }
    store:=Store{name:name}
    write_to_json(generate_store_tempate(store))
    store_init_success()
}

fn cmd_get(args []string){
    if !check_store_exist(){
        println('$pkg_name not found!')
        return
    }
    if args.len<=2{
        println('no git url input')
        return
    }
    git_url:=args[2]
    if !is_git_url(git_url){
        println('invaild git url "$git_url"')
        return
    }
    mut lib_name:=get_lib_name(git_url)
    if args.len==4{
        lib_name=args[3]
    }
    pkg_info:=fetch_pkg_from_git(lib_name,git_url)
    if pkg_info.name==''{
        return
    }
    save_pkginfo_to_store(pkg_info)
    fetch_done(lib_name)
}

fn cmd_install(){
    if !check_store_exist(){
        println('$pkg_name not found!')
        return
    }
    store:=load_to_store() or {
        load_store_failed()
        return
    }

    if store.packages.len==0{
        println('nothing to install')
        return
    }

    for p in store.packages{
        fetch_pkg_from_git(p.name,p.repo)
    }
    install_complete()
}

fn cmd_ls(){
    store:=load_to_store() or {
        load_store_failed()
        return
    }
    println('[installed packages]')
    if store.packages.len==0{
        return
    }
    for p in store.packages{
        println('$p.name        --  $p.repo')
    }
}

fn cmd_rm(args []string){
    mut names:=args[2..]
    if names.len==0{
        println('nothing to remove')
        return
    }
    // todo 当数组去重方法distinct实现后启用
    //names=names.distinct()
    names=string_array_distinct(names)
    mut store:=load_to_store() or {
        load_store_failed()
        return
    }
    if store.packages.len==0{
        println('nothing to remove')
        return
    }
    mut pkgs:=[]PkgInfo{}
    mut rm_names:=[]string{}
    for p in store.packages{
        if p.name in names{
            rm_names<<p.name
        }else{
            pkgs<<p
        }
    }
    store.packages=pkgs
    content:=generate_store_tempate(store)
    write_to_json(content)
    rm_name:=rm_names.str()
    println('remove packages:$rm_name done.')
}

fn cmd_default(cmd string){
    command_not_found(cmd)
}
