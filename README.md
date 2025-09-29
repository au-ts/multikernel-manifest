# multikernel-manifest

This is a manifest containing git submodules describing the current working commits
of the seL4 multikernel work.

## Running / Building

```sh
$ git clone --recurse-submodules https://github.com/au-ts/multikernel-manifest
$ cd multikernel-manifest
# on QEMU. specific examples choose by editing inside
$ ./run-qemu.sh
# on odroid (if you are at Trustworthy Systems and can use the Machine Queue)
$ ./run-odroid.sh
```

## Changes for Microkit users

From the perspective of a Microkit user, there should be minimal differences
when making a Microkit system.

* When `cpu` is specified, the PD will be assigned to the kernel running on that
  core. For example, a PD with `cpu=1` means that it will run on the 2nd core.
* As a consequence of multikernels, parent PDs cannot have children across cores
  and PPcs cannot happen betweeen PDs on different cores.
* The multikernel configuration requires a separate board build, e.g the `odroidc4`
  multikernel configuration is called `odroidc4_multikernel`. To add a new multikernel
  board configuration for a different platform, add the following two kernel configuration options:
    * `KernelEnableMultikernelSupport`
    * `KernelMaxNumNodes`
  Also add the number of multikernels required as part of the `BoardInfo`, e.g `multikernels=2`.

## Working Configurations

- Currently, only the debug build of the kernel runs. The release version
  complains about various warnings and unused variables.

- QEMU and OdroidC4 are the development platforms.

- There are 3 new microkit examples:

    - 'multikernel': which sends a few cross-core notifications.

        <details>
            <summary>log output</summary>

            ```
            LDR|INFO: Flags:                0x0000000000000001
                         seL4 configured as hypervisor
            LDR|INFO: Kernel: 0x0000000000000000
            LDR|INFO: Kernel: 0x0000000000000001
            LDR|INFO: region: 0x00000000   addr: 0x0000000060000000   size: 0x0000000000246000   offset: 0x0000000000000000   type: 0x0000000000000001
            LDR|INFO: region: 0x00000001   addr: 0x0000000061000000   size: 0x0000000000246000   offset: 0x0000000000246000   type: 0x0000000000000001
            LDR|INFO: region: 0x00000002   addr: 0x000000006024a000   size: 0x0000000000009970   offset: 0x000000000048c000   type: 0x0000000000000001
            LDR|INFO: region: 0x00000003   addr: 0x000000006124a000   size: 0x0000000000009970   offset: 0x0000000000495970   type: 0x0000000000000001
            LDR|INFO: region: 0x00000004   addr: 0x0000000060246000   size: 0x0000000000001080   offset: 0x000000000049f2e0   type: 0x0000000000000001
            LDR|INFO: region: 0x00000005   addr: 0x0000000060248000   size: 0x00000000000008c0   offset: 0x00000000004a0360   type: 0x0000000000000001
            LDR|INFO: region: 0x00000006   addr: 0x0000000060249000   size: 0x0000000000000090   offset: 0x00000000004a0c20   type: 0x0000000000000001
            LDR|INFO: region: 0x00000007   addr: 0x0000000061246000   size: 0x0000000000001080   offset: 0x00000000004a0cb0   type: 0x0000000000000001
            LDR|INFO: region: 0x00000008   addr: 0x0000000061248000   size: 0x0000000000000950   offset: 0x00000000004a1d30   type: 0x0000000000000001
            LDR|INFO: region: 0x00000009   addr: 0x0000000061249000   size: 0x0000000000000090   offset: 0x00000000004a2680   type: 0x0000000000000001
            LDR|INFO: copying region 0x00000000
            LDR|INFO: copying region 0x00000001
            LDR|INFO: copying region 0x00000002
            LDR|INFO: copying region 0x00000003
            LDR|INFO: copying region 0x00000004
            LDR|INFO: copying region 0x00000005
            LDR|INFO: copying region 0x00000006
            LDR|INFO: copying region 0x00000007
            LDR|INFO: copying region 0x00000008
            LDR|INFO: copying region 0x00000009
            LDR|INFO: Configuring GICv2 for ARM
            LDR|INFO: # of multikernels is 2
            LDR|INFO: CurrentEL=EL2
            LDR|INFO: Resetting CNTVOFF
            LDR|INFO: Boot CPU ID (0)
            LDR|INFO: Starting other CPUs (0x00000001)
            LDR|INFO: CurrentEL=EL2
            LDR|INFO: Resetting CNTVOFF
            LDR|INFO: secondary (CPU 0x00000001) has MPIDR_EL1: 0x0000000080000001
            LDR|INFO: enabling MMU (CPU 0x00000001)
            LDR|INFO: jumping to kernel (CPU 0x00000001)
            LDR|INFO: enabling self MMU
            LDR|INFO: jumping to first kernel
            LDR|INFO: Kernel starting: 0
                    has entry point: 0x000000ffff000000
                    has kernel_boot_info_p: 0x0000000070013030
            hi
            kernel boot info addr: 0x70013030
            root task v_entry: 0x8a000000
            num_kernel_regions: 1
            num_ram_regions: 1
            num_root_task_regions: 1
            num_reserved_regions: 1
            kernel_regions addr: 0x70013048
            ram_regions addr: 0x70013058
            root_task_regions addr: 0x70013068
            reserved_regions addr: 0x70013088
            end of kernel boot info addr: 0x70013098
            kernel_regions[0].base = 0x60000000
            kernel_regions[0].end = 0x0
            ram_regions[0].base = 0x60000000
            ram_regions[0].end = 0x61000000
            root_task_regions[0].paddr_base = 0x6024a000
            root_task_regions[0].paddr_end = 0x60254000
            root_task_regions[0].vaddr_base = 0x8a000000
            reserved_regions[0].base = 0x60246000
            reserved_regions[0].end = 0x6024a000
            Bootstrapping kernel
            available phys memory regions: 1
              [60000000..61000000)
            reserved phys memory regions: 3
              [60000000..60246000)
              [60246000..6024a000)
              [6024a000..60254000)
            MPIDR_EL1: 80000000
            MPIDR_EL1:U: multiprocessor
            MPIDR_EL1:MT: no SMT
            MPIDR_EL1:Aff0: 0
            MPIDR_EL1:Aff1: 0
            MPIDR_EL1:Aff2: 0
            MPIDR_EL1:Aff3: 0
            Booting all finished, dropped to user space
            MON|INFO: Microkit Bootstrap
            MON|INFO: bootinfo untyped list matches expected list
            current node: 0x0000000000000000
            num nodes: 0x0000000000000002
            bootinfo untyped.end: 0x0000000000000059
            MON|INFO: bootinfo untyped list matches expected list
            MON|INFO: Number of bootstrap invocations: 0x00000009
            MON|INFO: Number of system invocations:    0x0000003e
            MON|INFO: completed bootstrap invocations
            MON|INFO: completed system invocations
            core0: hello, world (from core 0)
            core0: shared_v: 50331648
            core0: shared_p: 3221221376
            core0: shared value: 0
            LDR|INFO: Kernel starting: 1
                    has entry point: 0x000000ffff000000
                    has kernel_boot_info_p: 0x0000000070014030
            hi
            kernel boot info addr: 0x70014030
            root task v_entry: 0x8a000000
            num_kernel_regions: 1
            num_ram_regions: 1
            num_root_task_regions: 1
            num_reserved_regions: 1
            kernel_regions addr: 0x70014048
            ram_regions addr: 0x70014058
            root_task_regions addr: 0x70014068
            reserved_regions addr: 0x70014088
            end of kernel boot info addr: 0x70014098
            kernel_regions[0].base = 0x61000000
            kernel_regions[0].end = 0x0
            ram_regions[0].base = 0x61000000
            ram_regions[0].end = 0x62000000
            root_task_regions[0].paddr_base = 0x6124a000
            root_task_regions[0].paddr_end = 0x61254000
            root_task_regions[0].vaddr_base = 0x8a000000
            reserved_regions[0].base = 0x61246000
            reserved_regions[0].end = 0x6124a000
            Bootstrapping kernel
            available phys memory regions: 1
              [61000000..62000000)
            reserved phys memory regions: 3
              [61000000..61246000)
              [61246000..6124a000)
              [6124a000..61254000)
            MPIDR_EL1: 80000001
            MPIDR_EL1:U: multiprocessor
            MPIDR_EL1:MT: no SMT
            MPIDR_EL1:Aff0: 1
            MPIDR_EL1:Aff1: 0
            MPIDR_EL1:Aff2: 0
            MPIDR_EL1:Aff3: 0
            Booting all finished, dropped to user space
            MON|INFO: Microkit Bootstrap
            MON|INFO: bootinfo untyped list matches expected list
            current node: 0x0000000000000001
            num nodes: 0x0000000000000002
            bootinfo untyped.end: 0x0000000000000059
            MON|INFO: bootinfo untyped list matches expected list
            MON|INFO: Number of bootstrap invocations: 0x00000009
            MON|INFO: Number of system invocations:    0x0000003e
            MON|INFO: completed bootstrap invocations
            MON|INFO: completed system invocations
            core1: hello, world (from core 1)
            core1: shared_v: 50331648
            core1: shared_p: 3221221376
            core1: shared value: 0
            core1: new shared value: 128
            core0: notified: 0 (cross core)
            core0: shared value: 128
            ```
        </details>


    - 'multikernel_memory': which sends cross-core notifications and writes/reads from shared memory

        <details>
            <summary>log output</summary>
            ```
            LDR|INFO: Flags:                0x0000000000000001
                         seL4 configured as hypervisor
            LDR|INFO: Kernel: 0x0000000000000000
            LDR|INFO: Kernel: 0x0000000000000001
            LDR|INFO: region: 0x00000000   addr: 0x0000000060000000   size: 0x0000000000246000   offset: 0x0000000000000000   type: 0x0000000000000001
            LDR|INFO: region: 0x00000001   addr: 0x0000000061000000   size: 0x0000000000246000   offset: 0x0000000000246000   type: 0x0000000000000001
            LDR|INFO: region: 0x00000002   addr: 0x000000006024c000   size: 0x0000000000009970   offset: 0x000000000048c000   type: 0x0000000000000001
            LDR|INFO: region: 0x00000003   addr: 0x0000000061249000   size: 0x0000000000009970   offset: 0x0000000000495970   type: 0x0000000000000001
            LDR|INFO: region: 0x00000004   addr: 0x0000000060246000   size: 0x0000000000001188   offset: 0x000000000049f2e0   type: 0x0000000000000001
            LDR|INFO: region: 0x00000005   addr: 0x0000000060248000   size: 0x0000000000000920   offset: 0x00000000004a0468   type: 0x0000000000000001
            LDR|INFO: region: 0x00000006   addr: 0x0000000060249000   size: 0x0000000000000080   offset: 0x00000000004a0d88   type: 0x0000000000000001
            LDR|INFO: region: 0x00000007   addr: 0x000000006024a000   size: 0x0000000000000920   offset: 0x00000000004a0e08   type: 0x0000000000000001
            LDR|INFO: region: 0x00000008   addr: 0x000000006024b000   size: 0x0000000000000080   offset: 0x00000000004a1728   type: 0x0000000000000001
            LDR|INFO: region: 0x00000009   addr: 0x0000000061246000   size: 0x0000000000000a88   offset: 0x00000000004a17a8   type: 0x0000000000000001
            LDR|INFO: region: 0x0000000a   addr: 0x0000000061247000   size: 0x0000000000000968   offset: 0x00000000004a2230   type: 0x0000000000000001
            LDR|INFO: region: 0x0000000b   addr: 0x0000000061248000   size: 0x0000000000000080   offset: 0x00000000004a2b98   type: 0x0000000000000001
            LDR|INFO: copying region 0x00000000
            LDR|INFO: copying region 0x00000001
            LDR|INFO: copying region 0x00000002
            LDR|INFO: copying region 0x00000003
            LDR|INFO: copying region 0x00000004
            LDR|INFO: copying region 0x00000005
            LDR|INFO: copying region 0x00000006
            LDR|INFO: copying region 0x00000007
            LDR|INFO: copying region 0x00000008
            LDR|INFO: copying region 0x00000009
            LDR|INFO: copying region 0x0000000a
            LDR|INFO: copying region 0x0000000b
            LDR|INFO: Configuring GICv2 for ARM
            LDR|INFO: # of multikernels is 2
            LDR|INFO: CurrentEL=EL2
            LDR|INFO: Resetting CNTVOFF
            LDR|INFO: Boot CPU ID (0)
            LDR|INFO: Starting other CPUs (0x00000001)
            LDR|INFO: CurrentEL=EL2
            LDR|INFO: Resetting CNTVOFF
            LDR|INFO: secondary (CPU 0x00000001) has MPIDR_EL1: 0x0000000080000001
            LDR|INFO: enabling MMU (CPU 0x00000001)
            LDR|INFO: jumping to kernel (CPU 0x00000001)
            LDR|INFO: enabling self MMU
            LDR|INFO: jumping to first kernel
            LDR|INFO: Kernel starting: 0
                    has entry point: 0x000000ffff000000
                    has kernel_boot_info_p: 0x0000000070013030
            hi
            kernel boot info addr: 0x70013030
            root task v_entry: 0x8a000000
            num_kernel_regions: 1
            num_ram_regions: 1
            num_root_task_regions: 1
            num_reserved_regions: 1
            kernel_regions addr: 0x70013048
            ram_regions addr: 0x70013058
            root_task_regions addr: 0x70013068
            reserved_regions addr: 0x70013088
            end of kernel boot info addr: 0x70013098
            kernel_regions[0].base = 0x60000000
            kernel_regions[0].end = 0x0
            ram_regions[0].base = 0x60000000
            ram_regions[0].end = 0x61000000
            root_task_regions[0].paddr_base = 0x6024c000
            root_task_regions[0].paddr_end = 0x60256000
            root_task_regions[0].vaddr_base = 0x8a000000
            reserved_regions[0].base = 0x60246000
            reserved_regions[0].end = 0x6024c000
            Bootstrapping kernel
            available phys memory regions: 1
              [60000000..61000000)
            reserved phys memory regions: 3
              [60000000..60246000)
              [60246000..6024c000)
              [6024c000..60256000)
            MPIDR_EL1: 80000000
            MPIDR_EL1:U: multiprocessor
            MPIDR_EL1:MT: no SMT
            MPIDR_EL1:Aff0: 0
            MPIDR_EL1:Aff1: 0
            MPIDR_EL1:Aff2: 0
            MPIDR_EL1:Aff3: 0
            Booting all finished, dropped to user space
            MON|INFO: Microkit Bootstrap
            MON|INFO: bootinfo untyped list matches expected list
            current node: 0x0000000000000000
            num nodes: 0x0000000000000002
            bootinfo untyped.end: 0x0000000000000059
            MON|INFO: bootinfo untyped list matches expected list
            MON|INFO: Number of bootstrap invocations: 0x00000009
            MON|INFO: Number of system invocations:    0x0000003d
            MON|INFO: completed bootstrap invocations
            MON|INFO: completed system invocations
            core0_B: hello, world (from core 0)
            core0_B: notifying same core on 5
            core0_A: hello, world (from core 0)
            core0_A: notifying same core on 5
            core0_A: notified: 5 (same core)
            core0_B: notified: 5 (same core)
            LDR|INFO: Kernel starting: 1
                    has entry point: 0x000000ffff000000
                    has kernel_boot_info_p: 0x0000000070014030
            hi
            kernel boot info addr: 0x70014030
            root task v_entry: 0x8a000000
            num_kernel_regions: 1
            num_ram_regions: 1
            num_root_task_regions: 1
            num_reserved_regions: 1
            kernel_regions addr: 0x70014048
            ram_regions addr: 0x70014058
            root_task_regions addr: 0x70014068
            reserved_regions addr: 0x70014088
            end of kernel boot info addr: 0x70014098
            kernel_regions[0].base = 0x61000000
            kernel_regions[0].end = 0x0
            ram_regions[0].base = 0x61000000
            ram_regions[0].end = 0x62000000
            root_task_regions[0].paddr_base = 0x61249000
            root_task_regions[0].paddr_end = 0x61253000
            root_task_regions[0].vaddr_base = 0x8a000000
            reserved_regions[0].base = 0x61246000
            reserved_regions[0].end = 0x61249000
            Bootstrapping kernel
            available phys memory regions: 1
              [61000000..62000000)
            reserved phys memory regions: 3
              [61000000..61246000)
              [61246000..61249000)
              [61249000..61253000)
            MPIDR_EL1: 80000001
            MPIDR_EL1:U: multiprocessor
            MPIDR_EL1:MT: no SMT
            MPIDR_EL1:Aff0: 1
            MPIDR_EL1:Aff1: 0
            MPIDR_EL1:Aff2: 0
            MPIDR_EL1:Aff3: 0
            Booting all finished, dropped to user space
            MON|INFO: Microkit Bootstrap
            MON|INFO: bootinfo untyped list matches expected list
            current node: 0x0000000000000001
            num nodes: 0x0000000000000002
            bootinfo untyped.end: 0x000000000000005a
            MON|INFO: bootinfo untyped list matches expected list
            MON|INFO: Number of bootstrap invocations: 0x00000009
            MON|INFO: Number of system invocations:    0x00000028
            MON|INFO: completed bootstrap invocations
            MON|INFO: completed system invocations
            core1: hello, world (from core 1)
            core1: signalling from core 1 to core 0
            core0_A: notified: 0 (cross core)
            core0_A: replying from core 0 to core 1
            core1: notified: 0 (cross core)
            core1: replying from core 1 to core 0
            core0_A: notified: 0 (cross core)
            core0_A: replying from core 0 to core 1
            core1: notified: 0 (cross core)
            core1: replying from core 1 to core 0
            core0_A: notified: 0 (cross core)
            core0_A: replying from core 0 to core 1
            core1: notified: 0 (cross core)
            core1: replying from core 1 to core 0
            core0_A: notified: 0 (cross core)
            core0_A: replying from core 0 to core 1
            core1: notified: 0 (cross core)
            core1: replying from core 1 to core 0
            core0_A: notified: 0 (cross core)
            core0_A: replying from core 0 to core 1
            core1: notified: 0 (cross core)
            core1: replying from core 1 to core 0
            core0_A: notified: 0 (cross core)
            core0_A: replying from core 0 to core 1
            core1: notified: 0 (cross core)
            core1: stopping after 5 notifications
            ```
        </details>


    - 'multikernel_timer': this only works on Odroid; it implements a timer driver and sends notifications
                           and data cross-core to a client.

        <details>
            <summary>log output</summary>
            ```
            LDR|INFO: Flags:                0x0000000000000001
                         seL4 configured as hypervisor
            LDR|INFO: Kernel: 0x0000000000000000
            LDR|INFO: Kernel: 0x0000000000000001
            LDR|INFO: region: 0x00000000   addr: 0x0000000000000000   size: 0x000000000024a000   offset: 0x0000000000000000   type: 0x0000000000000001
            LDR|INFO: region: 0x00000001   addr: 0x0000000001000000   size: 0x000000000024a000   offset: 0x000000000024a000   type: 0x0000000000000001
            LDR|INFO: region: 0x00000002   addr: 0x000000000024e000   size: 0x0000000000009970   offset: 0x0000000000494000   type: 0x0000000000000001
            LDR|INFO: region: 0x00000003   addr: 0x000000000124d000   size: 0x0000000000009970   offset: 0x000000000049d970   type: 0x0000000000000001
            LDR|INFO: region: 0x00000004   addr: 0x000000000024a000   size: 0x0000000000001630   offset: 0x00000000004a72e0   type: 0x0000000000000001
            LDR|INFO: region: 0x00000005   addr: 0x000000000024c000   size: 0x00000000000009d8   offset: 0x00000000004a8910   type: 0x0000000000000001
            LDR|INFO: region: 0x00000006   addr: 0x000000000024d000   size: 0x00000000000000b0   offset: 0x00000000004a92e8   type: 0x0000000000000001
            LDR|INFO: region: 0x00000007   addr: 0x000000000124a000   size: 0x0000000000000ed0   offset: 0x00000000004a9398   type: 0x0000000000000001
            LDR|INFO: region: 0x00000008   addr: 0x000000000124b000   size: 0x00000000000008f0   offset: 0x00000000004aa268   type: 0x0000000000000001
            LDR|INFO: region: 0x00000009   addr: 0x000000000124c000   size: 0x0000000000000090   offset: 0x00000000004aab58   type: 0x0000000000000001
            LDR|INFO: copying region 0x00000000
            LDR|INFO: copying region 0x00000001
            LDR|INFO: copying region 0x00000002
            LDR|INFO: copying region 0x00000003
            LDR|INFO: copying region 0x00000004
            LDR|INFO: copying region 0x00000005
            LDR|INFO: copying region 0x00000006
            LDR|INFO: copying region 0x00000007
            LDR|INFO: copying region 0x00000008
            LDR|INFO: copying region 0x00000009
            LDR|INFO: Configuring GICv2 for ARM
            LDR|INFO: # of multikernels is 2
            LDR|INFO: CurrentEL=EL2
            LDR|INFO: Resetting CNTVOFF
            LDR|INFO: Boot CPU ID (0)
            LDR|INFO: Starting other CPUs (0x00000001)
            LDR|INFO: CurrentEL=EL2
            LDR|INFO: Resetting CNTVOFF
            LDR|INFO: secondary (CPU 0x00000001) has MPIDR_EL1: 0x0000000081000100
            LDR|INFO: enabling MMU (CPU 0x00000001)
            LDR|INFO: jumping to kernel (CPU 0x00000001)
            LDR|INFO: enabling self MMU
            LDR|INFO: jumping to first kernel
            LDR|INFO: Kernel starting: 0
                    has entry point: 0x000000ffff000000
                    has kernel_boot_info_p: 0x0000000020013030
            hi
            kernel boot info addr: 0x20013030
            root task v_entry: 0x8a000000
            num_kernel_regions: 1
            num_ram_regions: 1
            num_root_task_regions: 1
            num_reserved_regions: 1
            kernel_regions addr: 0x20013048
            ram_regions addr: 0x20013058
            root_task_regions addr: 0x20013068
            reserved_regions addr: 0x20013088
            end of kernel boot info addr: 0x20013098
            kernel_regions[0].base = 0x0
            kernel_regions[0].end = 0x0
            ram_regions[0].base = 0x0
            ram_regions[0].end = 0x1000000
            root_task_regions[0].paddr_base = 0x24e000
            root_task_regions[0].paddr_end = 0x258000
            root_task_regions[0].vaddr_base = 0x8a000000
            reserved_regions[0].base = 0x24a000
            reserved_regions[0].end = 0x24e000
            Bootstrapping kernel
            available phys memory regions: 1
              [0..1000000)
            reserved phys memory regions: 3
              [0..24a000)
              [24a000..24e000)
              [24e000..258000)
            MPIDR_EL1: 81000000
            MPIDR_EL1:U: multiprocessor
            MPIDR_EL1:MT: SMT
            MPIDR_EL1:Aff0: 0
            MPIDR_EL1:Aff1: 0
            MPIDR_EL1:Aff2: 0
            MPIDR_EL1:Aff3: 0
            Booting all finished, dropped to user space
            MON|INFO: Microkit Bootstrap
            MON|INFO: bootinfo untyped list matches expected list
            current node: 0x0000000000000000
            num nodes: 0x0000000000000002
            bootinfo untyped.end: 0x0000000000000053
            MON|INFO: bootinfo untyped list matches expected list
            MON|INFO: Number of bootstrap invocations: 0x00000009
            MON|INFO: Number of system invocations:    0x00000052
            MON|INFO: completed bootstrap invocations
            MON|INFO: completed system invocations
            Setting a timeout of 1 second.
            TIMER: Got timer interrupt!
            TIMER: Got timer interrupt!
            TIMER: Got timer interrupt!
            LDR|INFO: Kernel starting: 1
                    has entry point: 0x000000ffff000000
                    has kernel_boot_info_p: 0x0000000020014030
            hi
            kernel boot info addr: 0x20014030
            root task v_entry: 0x8a000000
            num_kernel_regions: 1
            num_ram_regions: 1
            num_root_task_regions: 1
            num_reserved_regions: 1
            kernel_regions addr: 0x20014048
            ram_regions addr: 0x20014058
            root_task_regions addr: 0x20014068
            reserved_regions addr: 0x20014088
            end of kernel boot info addr: 0x20014098
            kernel_regions[0].base = 0x1000000
            kernel_regions[0].end = 0x0
            ram_regions[0].base = 0x1000000
            ram_regions[0].end = 0x2000000
            root_task_regions[0].paddr_base = 0x124d000
            root_task_regions[0].paddr_end = 0x1257000
            root_task_regions[0].vaddr_base = 0x8a000000
            reserved_regions[0].base = 0x124a000
            reserved_regions[0].end = 0x124d000
            Bootstrapping kernel
            available phys memory regions: 1
              [1000000..2000000)
            reserved phys memory regions: 3
              [1000000..124a000)
              [124a000..124d000)
              [124d000..1257000)
            MPIDR_EL1: 81000100
            MPIDR_EL1:U: multiprocessor
            MPIDR_EL1:MT: SMT
            MPIDR_EL1:Aff0: 0
            MPIDR_EL1:Aff1: 1
            MPIDR_EL1:Aff2: 0
            MPIDR_EL1:Aff3: 0
            Booting all finished, dropped to user space
            MON|INFO: Microkit Bootstrap
            MON|INFO: bootinfo untyped list matches expected list
            current node: 0x0000000000000001
            num nodes: 0x0000000000000002
            bootinfo untyped.end: 0x0000000000000054
            MON|INFO: bootinfo untyped list matches expected list
            MON|INFO: Number of bootstrap invocations: 0x00000009
            MON|INFO: Number of system invocations:    0x00000038
            MON|INFO: completed bootstrap invocations
            MON|INFO: completed system invocations
            TIMER: Got timer interrupt!
            CLIENT: Got timer notification
            CLIENT: Current time is: 0x00000000eed0fe50
            TIMER: Got timer interrupt!
            CLIENT: Got timer notification
            CLIENT: Current time is: 0x000000012a7ae768
            TIMER: Got timer interrupt!
            CLIENT: Got timer notification
            CLIENT: Current time is: 0x000000016624f3a8
            TIMER: Got timer interrupt!
            CLIENT: Got timer notification
            CLIENT: Current time is: 0x00000001a1ceffe8
            TIMER: Got timer interrupt!
            CLIENT: Got timer notification
            CLIENT: Current time is: 0x00000001dd790c28
            ```
        </details>


- Some of the sDDF examples have been tested and work fine, when we zero out
  the memory for our asynchronous queues first. (This has not been done well,
  yet, so they only work on QEMU with the code in this repository for now).

## To-Do

See the [TODO](./TODO) file.


## seL4 Changes

1.  The kernel uses a fixed virtual memory address on AArch64, rather than
    an address based on the physical memory used that is located within the
    kernel physical memory ("direct mapping") window.

2.  The GIC is no longer initialised in the kernel; it is assumed initialised
    by the loader.

3.  The kernel boot protocol has changed so that reserved regions, physical memory (RAM),
    the root task regions, and the kernel physical region are passed via a
    "Kernel BootInfo" page by the loader, instead of a mix of generated-at-compile-time
    and passed in registers.


## microkit changes

-   The tool learns about a new parameter, "cpu", to the protection domain
    that tells it what CPU to place a protection domain on.

-   Previously, we used implicit indices in the array of protection domains,
    but since the system is built once per-core then the indices change between
    each build. The tool has been rewritten to address PDs by their name
    (which is unique) as opposed their index.

-   Shared information, such as which SGIs, and what physical addresses for
    shared memory are chosen quite arbitrarily before any systems are built.

-   The tool now picks arbitrary physical addresses for each kernel to run in
    at a spacing of 0x1000000 (kernel_elf_size_align).
