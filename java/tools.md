# Sdkman

## Install java (jdk)

**List versions**

```
sdk list java
```

Gives something like

```
================================================================================
Available Java Versions
================================================================================
 Vendor        | Use | Version      | Dist    | Status     | Identifier
--------------------------------------------------------------------------------
 AdoptOpenJDK  |     | 16.0.0.j9    | adpt    |            | 16.0.0.j9-adpt      
               |     | 11.0.10.hs   | adpt    |            | 11.0.10.hs-adpt     
               |     | 11.0.9.open  | adpt    |            | 11.0.9.open-adpt    
               | >>> | 11.0.4.hs    | adpt    | local only | 11.0.4.hs-adpt      
               |     | 8.0.275.open | adpt    |            | 8.0.275.open-adpt  
```

**Install chosen jdk**

```
sdk install java 8.0.275.open-adpt 
```

**Setup jdk**

```
$ sdk default java 8.0.275.open-adpt 
```

For per-project basis setup use the [env command](https://sdkman.io/usage)
